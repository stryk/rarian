class VotesController < ApplicationController

  before_filter :get_obj

  def up
    if user_signed_in?
      if current_user.is?(:admin)
        @obj.net_votes += 1
        @obj.save
      else
        begin
          authorize! :up, @obj, :message => "You must sign-in to vote."
          @company =  Company.friendly.find(params[:company_id].downcase)
          current_user.up_vote(@obj)
        rescue MakeVoteable::Exceptions::AlreadyVotedError
          # if the user clicks on the vote twice means user is unvoting
          current_user.unvote(@obj)
        end
      end
    else
      respond_to do |format|
        format.js {render 'signup'}
      end
    end
  end

  def down
    if user_signed_in?
      if current_user.is?(:admin)
        @obj.net_votes -= 1
        @obj.save
      else
        begin
          authorize! :up, @obj, :message => "You must sign-in to vote."
          @company =  Company.friendly.find(params[:company_id].downcase)
          current_user.down_vote(@obj)
        rescue MakeVoteable::Exceptions::AlreadyVotedError
          # if the user clicks on the vote twice means user is unvoting
          current_user.unvote(@obj)
        end
      end
    else
      respond_to do |format|
        format.js {render 'signup'}
      end
    end
  end

  def get_obj
    @obj = if !params[:blip_id].blank?
            Blip.where(:id => params[:blip_id]).last
           elsif !params[:pitch_id].blank?
             Pitch.friendly.find(params[:pitch_id])
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
