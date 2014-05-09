class AttachmentsController < ApplicationController
  load_and_authorize_resource

	def create
		attachment = Attachment.new
		attachment.company_id = params[:attachment][:company_id]
		attachment.user_id = params[:attachment][:user_id]
		attachment.description = params[:attachment][:description] if params[:attachment][:description].present?
		attachment.attached_file = params[:attachment][:attached_file]
		attachment.file_name = File.basename(params[:attachment][:attached_file].original_filename, ".*")
		attachment.file_type = File.extname(params[:attachment][:attached_file].original_filename)
		attachment.signature = Digest::SHA1.file(params[:attachment][:attached_file].tempfile).hexdigest
		attachment.file_size_in_kb = (File.size(params[:attachment][:attached_file].tempfile) / 1000).to_i
		attachment.scanned = false
		attachment.save!
	    redirect_to company_path(:id => params[:attachment][:company_id])
	end

end