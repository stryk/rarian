class AttachmentsController < ApplicationController
  load_and_authorize_resource

	def create
		begin
			attachment = Attachment.new
			attachment.company_id = params[:attachment][:company_id]
			attachment.user_id = params[:attachment][:user_id]
			attachment.description = params[:attachment][:description] if params[:attachment][:description].present?
			if params[:attachment][:attachable_id].present?
				attachment.attachable_id = params[:attachment][:attachable_id]
				attachment.attachable_type = params[:attachment][:attachable_type]
			end
			attachment.attached_file = params[:attachment][:attached_file]
			attachment.file_name = File.basename(params[:attachment][:attached_file].original_filename, ".*").downcase
			attachment.file_type = File.extname(params[:attachment][:attached_file].original_filename).downcase
			attachment.signature = Digest::SHA1.file(params[:attachment][:attached_file].tempfile).hexdigest
			attachment.file_size_in_kb = (File.size(params[:attachment][:attached_file].tempfile) / 1000).to_i
			attachment.scanned = false
			attachment.save!
			flash[:error] = 'File received and queued for virus scan.'
			if params[:attachment][:attachable_id].present?
				redirect_to pitch_path(:id => params[:attachment][:attachable_id])
			else
		    	redirect_to company_path(:id => params[:attachment][:company_id])
		    end
		rescue ActiveRecord::RecordInvalid
			flash[:error] = 'Invalid file extension'
			if params[:attachment][:attachable_id].present?
				redirect_to pitch_path(:id => params[:attachment][:attachable_id])
			else
		    	redirect_to company_path(:id => params[:attachment][:company_id])
		    end
		end

	end

	def update
		@attachment.description = params[:attachment][:description]
		if @attachment.save
			respond_to do |format|
	        	format.js
	      	end
	    else
	    	flash[:error] = 'Error - file description change could not be saved.'
	    	redirect_to company_path @attachment.company.slug
	    end
	end

	def download
		attachment = Attachment.find(params[:id])
		if user_signed_in?
			url = attachment.attached_file.url
			redirect_to url
		else
			flash[:notice] = "Unauthorized Download Attempt"
			redirect_to company_path(:id => attachment.company.slug)
		end
	end

	def destroy
		attachment = Attachment.find(params[:id])
    	attachment.destroy!
    	flash[:notice] = 'File has been deleted.'
    	redirect_to company_path(:id => attachment.company.slug)
    end

end