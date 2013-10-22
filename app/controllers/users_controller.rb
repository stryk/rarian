class UsersController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => :show

  def show
     @blips = current_user.blips
     @buypitchs =  current_user.pitches.buy_pitch
     @sellpitchs =  current_user.pitches.sell_pitch
     @question = current_user.questions
     @answer = current_user.answers
     @comment = current_user.comments

  end

  def new

  end

  def setting
    #raise User.new.no_day_newsletter.inspect
  end

  def credits

  end

  def update


  end

 def blips
   params[:sort_by] = 'asc' if params[:sort_by].blank?
   params[:range] = 10 if params[:range].blank?

   @blips = Blip.unscoped.order("created_at #{params[:sort_by]}").where("created_at between '#{Date.today - params[:range].to_i}' and '#{Date.today}'")
   respond_to do |format|
     format.js
     end
 end

  def buypitch
    params[:buy_range] = 10 if params[:buy_range].blank?
    params[:buyrange] = 'asc' if params[:buyrange].blank?
    @buypitchs = Pitch.unscoped.order("created_at #{params[:buyrange]}").where("created_at between '#{Date.today - params[:buy_range].to_i}' and '#{Date.today}'").buy_pitch
    respond_to do |format|
      format.js
    end
  end

  def sellpitch
    params[:sell_range] = 10 if params[:sell_range].blank?
    params[:sellrange] = 'asc' if params[:sellrange].blank?
    @sellpitchs = Pitch.unscoped.order("created_at #{params[:sellrange]}").where("created_at between '#{Date.today - params[:sell_range].to_i}' and '#{Date.today}'").sell_pitch

    respond_to do |format|
      format.js
    end
  end

  def question
    params[:question_range] = 10 if params[:question_range].blank?

    @questions = Question.unscoped.where("created_at between '#{Date.today - params[:question_range].to_i}' and '#{Date.today}'")

    respond_to do |format|
      format.js
    end
  end

  def answer
    params[:answer_range] = 10 if params[:answer_range].blank?

    @answers = Answer.unscoped.where("created_at between '#{Date.today - params[:answer_range].to_i}' and '#{Date.today}'")

    respond_to do |format|
      format.js
    end
  end

  def comment
    params[:comment_range] = 10 if params[:comment_range].blank?

    @comments = Comment.unscoped.where("created_at between '#{Date.today - params[:comment_range].to_i}' and '#{Date.today}'")

    respond_to do |format|
      format.js
    end
  end
end
