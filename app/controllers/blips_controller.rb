class BlipsController < ApplicationController
  load_and_authorize_resource

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
      current_user.unvote(@blip)
    end
  end

  def vote_down
    begin
      current_user.down_vote(@blip)
    rescue MakeVoteable::Exceptions::AlreadyVotedError
      current_user.unvote(@blip)
    end
  end
end
