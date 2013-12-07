class BlipsController < ApplicationController
  load_and_authorize_resource

  def index
    @company =  Company.friendly.find(params[:company_id])
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
end
