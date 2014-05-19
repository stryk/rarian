class ScanAttachmentWorker
	include Sidekiq::Worker

	def perform(id, retry_count = 0)
		attachment = Attachment.find(id)
		if Attachment.where('scanned = true AND signature = ?', attachment.signature).count>0
			existing_file = Attachment.where('scanned = true AND signature = ?', attachment.signature).first
			attachment.scanned = true
			attachment.scan_id = existing_file.scan_id
			attachment.scan_timestamp = existing_file.scan_timestamp
			attachment.scan_provider = existing_file.scan_provider
			attachment.save!
			return
		else
			if((Attachment.where('scan_timestamp > ?', Time.now - 1.minute).count) >= 4)
				# rate limit likely reached
				ScanAttachmentWorker.delay_for(1.minute, :retry => false).perform_async(attachment.id)
			else
				begin
					json_resp = virus_total(attachment)		
				rescue PermissionError
					if(retry_count < 5)
						retry_count += 1
						if(retry_count < 3)
							ScanAttachmentWorker.perform_async(attachment.id,retry_count)
						else
							ScanAttachmentWorker.delay_for(1.minute, :retry => false).perform_async(attachment.id,retry_count)
						end
					else
						return
					end
				rescue RateLimitError
					ScanAttachmentWorker.delay_for(5.minute, :retry => false).perform_async(attachment.id)
				end

				if json_resp.blank?
					ScanAttachmentWorker.delay_for(1.minute, :retry => false).perform_async(attachment.id)
				else
					if(json_resp['response_code'] == 1)
							if(json_resp['positives'] == 0)
								attachment.scanned = true
								attachment.scan_id = json_resp["scan_id"]
								attachment.scan_timestamp = DateTime.parse(json_resp["scan_date"])
								attachment.scan_provider = "virustotal"
								attachment.save!
							else
								# may be send a message that a virus was found.
								attachment.destroy!
							end
					elsif json_resp['response_code'] == 0
						VTScanWorker.perform_async(attachment.id)
					else
						if(retry_count < 3)
							ScanAttachmentWorker.delay_for((retry_count + 1).minute, :retry => false).perform_async(attachment.id, retry_count + 1)
						elsif retry_count < 5
							ScanAttachmentWorker.delay_for((retry_count + 1).hours, :retry => false).perform_async(attachment.id, retry_count + 1)
						else
							return
						end
				    end
				end
			end
		end
	end

	def virus_total(attachment)
		json_echo = nil
		vt_url = "https://www.virustotal.com/vtapi/v2/file/report"
		api_key = configatron.VIRUSTOTAL_API_KEY
		response = nil
		if attachment.scan_id.present?
			response = HTTParty.post(vt_url, :query => { apikey: api_key, resource: attachment.scan_id})

		else
			response = HTTParty.post(vt_url, :query => { apikey: api_key, resource: attachment.signature})
		end
		attachment.scan_timestamp = Time.now
		attachment.save!
		case response.code
		  when 200
			json_echo = JSON.parse(response.body)
		  when 403
		    raise PermissionError, "VirusTotal - 403 response, permission error"
		    
		  when 204
		  	raise RateLimitError, "VirusTotal - 204 response, rate limit reached"
		  else
		  	raise OtherVTError, "VirusTotal - " + response.code.to_s
		end
		
		return json_echo
	end

	def opswat(attachment)
		# opswat
		sha1_url = 'https://api.metascan-online.com/v1/hash/' + attachment.signature
		response = HTTParty.get(sha1_url, :headers => { "apikey" => configatron.OPSWAT_API_KEY})
		response_json = JSON.parse(response.body)
		unless response_json[sig] == "Not Found"
			# submit file for scan
		else
			# pull up result
		end

		return response
	end
end

class PermissionError < Exception
end
class RateLimitError < Exception
end
class OtherVTError < Exception
end