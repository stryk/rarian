class UsersController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => :show

  def show
    @blips = get_objects(@user.blips, params)
    @buypitchs = get_objects(@user.pitches.buy_pitch, params)
    @sellpitchs = get_objects(@user.pitches.sell_pitch, params)
    @question = get_objects(@user.questions, params)
    @answer = get_objects(@user.answers, params)
    @comment = get_objects(@user.comments, params)
  end

  def new

  end

  def setting

  end

  def follow
    current_user.follow(@user)
  end

  def unfollow
    current_user.stop_following(@user)
    render 'follow.js.erb'
  end

  def credits
    @credit_sum = 0
    @buy_pitches = current_user.pitches.buy_pitch.where("points > 0")
    @credit_sum += @buy_pitches.map(&:points).inject{|sum,x| sum + x } if !@buy_pitches.blank?
    @sell_pitches = current_user.pitches.sell_pitch.where("points > 0")
    @credit_sum += @sell_pitches.map(&:points).inject{|sum,x| sum + x } if !@sell_pitches.blank?
    @blips = current_user.blips.where("points > 0")
    @credit_sum += @blips.map(&:points).inject{|sum,x| sum + x } if !@blips.blank?
    @questions = current_user.questions.where("points > 0")
    @credit_sum += @questions.map(&:points).inject{|sum,x| sum + x } if !@questions.blank?
    @answers = current_user.answers.where("points > 0")
    @credit_sum += @answers.map(&:points).inject{|sum,x| sum + x } if !@answers.blank?
    @catalysts = current_user.catalysts.where("points > 0")
    @credit_sum += @catalysts.map(&:points).inject{|sum,x| sum + x } if !@catalysts.blank?
  end

  def update


  end

 def blips
   @blips = get_objects(current_user.blips, params)
   respond_to do |format|
     format.js
     end
 end

  def buypitch
    @buypitchs = get_objects(current_user.pitches.buy_pitch, params)
    respond_to do |format|
      format.js
    end
  end

  def sellpitch
    @sellpitchs = get_objects(current_user.pitches.sell_pitch, params)
    respond_to do |format|
      format.js
    end
  end

  def question
    @questions = get_objects(current_user.questions, params)

    respond_to do |format|
      format.js
    end
  end

  def answer
    @answers = get_objects(current_user.answers, params)

    respond_to do |format|
      format.js
    end
  end

  def comment
    @comments = get_objects(current_user.comments, params)

    respond_to do |format|
      format.js
    end
  end

  def imageuploader
    current_user.update_attributes!(params[:user])
    redirect_to user_path(current_user)
  end

  def aboutuser

  end

  private
  def get_objects(obj_relationship, params={})
    params[:sort_by] = 'desc' if params[:sort_by].blank?
    params[:range] = 10 if params[:range].blank?

    obj_relationship.order("created_at #{params[:sort_by]}").where("created_at between '#{Date.today - params[:range].to_i}' and '#{Date.today}'")

  end

end
