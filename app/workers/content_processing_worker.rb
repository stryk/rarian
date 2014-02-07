class ContentProcessingWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false

	def perform(id, is_pitch)

		article = nil
		content = nil

		if is_pitch
			article = Pitch.find_by_id(id)
			content = article.multimedia_content rescue nil
		else
			article = Answer.find_by_id(id)
			content = article.content rescue nil
		end
		if article.blank?
			return
		end
		article.offloaded = true


		s3 = AWS::S3.new
		bucket = s3.buckets[configatron.AWS_S3_BUCKET]

		parse_content = Nokogiri::HTML.fragment(content)

	    parse_content.css("a").each do |image_tag|
	    	
	      	if image_tag['class'] == "nModal"
		      content_img_link = image_tag["href"]
		      unless content_img_link[0..4] == 'https'
				# changing the file_name in the path
				image_filename = File.basename(content_img_link)
				image_pathname = File.dirname(content_img_link)
				random_hex = SecureRandom.hex
				
				new_key = image_pathname + '/' + random_hex + '/' + image_filename
				imagefile = File.open(Rails.root.join("public").to_s + content_img_link,'r+b')
				content_md5 = Digest::MD5.base64digest(File.read(imagefile.path))
				obj = bucket.objects[new_key].write(:file => imagefile, :content_md5 => content_md5)
				if obj.exists? && image_tag.child.present?
					
					image_tag["href"] = 'https://' + configatron.AWS_S3_BUCKET + '.s3.amazonaws.com/' + new_key
					child_img_link = image_tag.child['src']
					child_filename = File.basename(child_img_link)
					child_pathname = File.dirname(child_img_link)
					new_child_key = image_pathname + '/' + random_hex + '/' + child_filename
					child_file = File.open(Rails.root.join("public").to_s + child_img_link,'r+b')
					child_content_md5 = Digest::MD5.base64digest(File.read(child_file.path))
					child_obj = bucket.objects[new_child_key].write(:file => child_file, :content_md5 => child_content_md5)
					if child_obj.exists?						
						image_tag.child['src'] = 'https://' + configatron.AWS_S3_BUCKET + '.s3.amazonaws.com/' + new_child_key
						if is_pitch
							article.multimedia_content = parse_content.to_html
						else
							article.content = parse_content.to_html
						end
						article.s3objects.build(checksum: content_md5, key: obj.key, bucket: configatron.AWS_S3_BUCKET)
						article.s3objects.build(checksum: child_content_md5, key: child_obj.key, bucket: configatron.AWS_S3_BUCKET)
						article.save
						File.delay_for(30.minutes, :retry => false).delete(imagefile.path)
						File.delay_for(30.minutes, :retry => false).delete(child_file.path)
						
					end
				end
		  	  end
	        end
	    end
	end
end
