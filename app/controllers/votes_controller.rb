class VotesController < ApplicationController

  before_filter :get_obj

  def up
    begin
      authorize! :up, @obj
      @company =  Company.friendly.find(params[:company_id])
      current_user.up_vote(@obj)
    rescue MakeVoteable::Exceptions::AlreadyVotedError
      # if the user clicks on the vote twice means user is unvoting
      current_user.unvote(@obj)
    end
  end

  def down
    begin
      authorize! :up, @obj
      @company =  Company.friendly.find(params[:company_id])
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
           elsif !params[:answer_id].blank?
             Answer.where(:id =>  params[:answer_id]).last
           elsif !params[:question_id].blank?
             Question.where(:id =>  params[:question_id]).last
           elsif !params[:competitor_id].blank?
             Competitor.where(:id =>  params[:competitor_id]).last
           elsif !params[:risk_id].blank?
             Risk.where(:id =>  params[:risk_id]).last
           end
  end

end
