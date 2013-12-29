class BlipsController < ApplicationController
  load_and_authorize_resource

  def index
    @company =  Company.friendly.find((params[:company_id]).downcase)
    @blips = get_records(@company.blips, params, {:date_option => false })
    respond_to do |format|
      format.js
    end
  end

  def create
    @bilp = Blip.create(params[:blip])
    respond_to do |format|
      format.js
    end
  end

  def update
    @blip.update_attributes(:content => params[:blip][:content])
    if @blip.errors.blank?
      respond_to do |format|
        format.js
      end
    else
    end
  end

  def destroy
    deleted_blip = Blip.where(:id => params[:id]).last
    @deleted_blip_id = deleted_blip.id
    deleted_blip.destroy
    respond_to do |format|
      format.js {render 'destroy'}
    end
  end
end
