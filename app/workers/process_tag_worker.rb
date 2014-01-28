# Ready for use, but has drawback - not an immediate response.

class ProcessTagWorker
	include Sidekiq::Worker

	def perform(id, is_pitch)
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
		parse_content = Nokogiri::HTML.fragment(content)
	    parse_content.css("img").each do |image_tag|
	      content_img_link = image_tag["src"]
	      # changing the file_name in the path
	      image_filename = File.basename(content_img_link)
	      image_pathname = File.dirname(content_img_link)
	      new_filename = image_filename[8..-1]
	      new_img_link = image_pathname + '/' + new_filename

	      # creating a new <a href> tag
	      image_tag.name = "a"
	      image_tag['href'] = new_img_link
	      image_tag['class'] = "nModal"
	      image_tag['title'] = ""
	      image_tag.remove_attribute("src")
	      image_tag.remove_attribute("alt")


	      child_tag = Nokogiri::XML::Node.new "img", parse_content
	      child_tag['src'] = content_img_link
	      child_tag['alt'] = "Missing Image"
	      child_tag.parent = image_tag
	    end
	    if is_pitch
	    	article.multimedia_content = parse_content.to_html
	    else
	    	article.content = parse_content.to_html
	    end
    	article.save
	end
end
