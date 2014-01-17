class CompetitorsController < ApplicationController
  load_and_authorize_resource :company

  def create
    @competitor = @company.competitors.create(:competitor_id => params[:competitor][:competitor_id], :user_id => current_user.id)
    if @competitor.errors.blank?
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js { render js: "alert('Invalid company: Company does not exist or already in the list.');"}
      end
    end
  end

  def destroy
  	@deleted_id = params[:id]
    Competitor.find_by_id(@deleted_id).destroy
    respond_to do |format|
      format.js { render 'delete' }
    end
  end
end
