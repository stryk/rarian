class BlipsController < ApplicationController
  load_and_authorize_resource

  def index
    @company =  Company.find(params[:company_id])
    @blips = Blip.unscoped.where(company_id: @company.id).order(created_at: params[:sort_by].to_sym).load
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

  def vote_up
    begin
      current_user.up_vote(@blip)
    rescue MakeVoteable::Exceptions::AlreadyVotedError
      # if the user clicks on the vote twice means user is unvoting
      current_user.unvote(@blip)
    end
  end

  def vote_down
    begin
      current_user.down_vote(@blip)
    rescue MakeVoteable::Exceptions::AlreadyVotedError
      # if the user clicks on the vote twice means user is unvoting
      current_user.unvote(@blip)
    end
  end
end
