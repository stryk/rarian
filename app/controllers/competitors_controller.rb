class CompetitorsController < ApplicationController
  load_and_authorize_resource :company

  def create
    if @company.competitors.where(:competitor_id => params[:competitor][:competitor_id]).blank?
      @company.competitors.create(:competitor_id => params[:competitor][:competitor_id], :user_id => current_user.id)
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
