class VotesController < ApplicationController

  before_filter :get_obj

  def up
    begin
      authorize! :up, @obj
      current_user.up_vote(@obj)
    rescue MakeVoteable::Exceptions::AlreadyVotedError
      # if the user clicks on the vote twice means user is unvoting
      current_user.unvote(@obj)
    end
  end

  def down
    begin
      authorize! :up, @obj
      current_user.down_vote(@obj)
    rescue MakeVoteable::Exceptions::AlreadyVotedError
      # if the user clicks on the vote twice means user is unvoting
      current_user.unvote(@obj)
    end
  end

  def get_obj
    @obj = if !params[:blip_id].blank?
            Blip.where(:id => params[:blip_id]).last
           elsif !params[:pitch_id].blank?
             Pitch.where(:id => params[:pitch_id]).last
           end
  end

end
