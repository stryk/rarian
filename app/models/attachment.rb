class Attachment < ActiveRecord::Base
	mount_uploader :attached_file, AttachedFileUploader
	store_in_background :attached_file
	validates :file_size => { maximum: 50000 }	


	private


end
