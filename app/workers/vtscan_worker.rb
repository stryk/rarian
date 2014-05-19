
class VirustotalNewScan
  include HTTMultiParty
  base_uri "https://www.virustotal.com/vtapi/v2/file/scan"
end


class VTScanWorker
	include Sidekiq::Worker

	def perform(id, retry_count = 0)
		attachment = Attachment.find(id)
		black_list = ['.﻿bat', '.chm', '.cmd', '.com', '.cpl', '.crt','.exe','.hlp','.hta','.inf','.ins','.isp','.jse','.lnk','.mdb','.ms','.pcd','.pif','.reg','.scr','.sct','.shs','.vb','.ws','.zip', '.tar', '.tz']
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
				file_to_send = File.new(File.join(directory, attachment.file_name + attachment.file_type))
				# todo send multipart upload to virustotal
				
				extension = File.extname(file_to_send)
				if black_list.include? extension
					attachment.destroy!
					return
				else
					attachment.file_type = extension
					attachment.save!
				end
				response = VirustotalNewScan.post('', :query => {apikey: configatron.VIRUSTOTAL_API_KEY, 
						file: file_to_send}, 
						:detect_mime_type => true)
				attachment.scan_timestamp = Time.now
				attachment.save!
				if(response.code == 200)
					json_resp = JSON.parse(response.body)
					attachment.scan_id = json_resp["scan_id"]
					attachment.save!
					ScanAttachmentWorker.delay_for(2.minute).perform_async(attachment.id)
				else
					if retry_count < 3
						VTScanWorker.delay_for((retry_count + 1).minute).perform_async(attachment.id, retry_count + 1)
					end
				end
			else
				if retry_count < 3
					VTScanWorker.delay_for((retry_count + 1).minute).perform_async(attachment.id, retry_count + 1)
				else
					attachment.destroy!
				end
			end
		end
	end
end






