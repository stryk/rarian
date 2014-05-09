
class VirustotalNewScan
  include HTTMultiParty
  base_uri "https://www.virustotal.com/vtapi/v2/file/scan"
end


class VTScanWorker
	include Sidekiq::Worker

	def perform(id, retry_count = 0)
		attachment = Attachment.find(id)
		if((Attachment.where('scan_timestamp > ?', Time.now - 1.minute).count) >= 4)
			# rate limit likely reached
			VTScanWorker.delay_for(1.minute, :retry => false).perform_async(attachment.id)
		else
			if attachment.attached_file.present?

				directory = Rails.root.to_s + "/tmp"
			  	File.open(File.join(directory, attachment.file_name + attachment.file_type), 'wb') do |file|
				    attachment.attached_file.read do |chunk|
				      file.write(chunk)
				    end
				end
				# todo send multipart upload to virustotal
				response = VirustotalNewScan.post('', :query => {apikey: configatron.VIRUSTOTAL_API_KEY, 
						file: File.new(File.join(directory, attachment.file_name + attachment.file_type))}, 
						:detect_mime_type => true)
				attachment.scan_timestamp = Time.now
				attachment.save!
				if(response.code == 200)
					json_resp = JSON.parse(response.body)
					attachment.scan_id = json_resp["scan_id"]
					attachment.save!
					ScanAttachmentWorker.delay_for(1.minute).perform_async(attachment.id)
				else
					if retry_count < 5
						VTScanWorker.delay_for((retry_count + 1).minute).perform_async(attachment.id, retry_count + 1)
					else
						attachment.destroy!
					end
				end
			else
				if retry_count < 5
					VTScanWorker.delay_for((retry_count + 1).minute).perform_async(attachment.id, retry_count + 1)
				else
					attachment.destroy!
				end
			end
		end
	end
end






