class Attachment < ActiveRecord::Base
	mount_uploader :attached_file, AttachedFileUploader
	after_create :scan_attachment
	store_in_background :attached_file
	validates :file_size_in_kb, :numericality => { :less_than_or_equal_to => 50000 }
	private

	def scan_attachment
		ScanAttachmentWorker.delay_for(1.minute).perform_async(id)
	end

end
