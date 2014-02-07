class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  load_and_authorize_resource
  skip_authorize_resource :only => :show

  def show
    params[:sort_by] = 'desc' if params[:sort_by].blank?
    @buypitchs = get_records(@user.pitches.buy_pitch, params, {:type => 'longpitchs'})
    @sellpitchs = get_records(@user.pitches.sell_pitch, params, {:type => 'shortpitchs'})
    @blips = get_records(@user.blips, params, {:type => 'blips'})
    @question = get_objects(@user.questions, params)
    @answer = get_objects(@user.answers, params)
    @comment = get_objects(@user.comments, params)
    respond_to do |format|
      format.js {
        @append = true
        if params[:lp_page].present?
          @pitchs = @buypitchs
          render 'buypitch.js.erb'
        elsif params[:sp_page].present?
          @pitchs = @sellpitchs
          render 'sellpitch.js.erb'
        elsif params[:blp_page].present?
          render 'blips.js.erb'
        end
      }
      format.html
    end
  end

  def new

  end

  def setting

  end

  def follow
    if current_user.present?
      current_user.follow(@user)
      EmailFollowActionWorker.perform_async(current_user.id, @user.id)
    end
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
    @append = true if params[:blp_page].present?
    @user = User.find_by_id(params[:uid])
    if @user.present?
      @blips = get_records(@user.blips, params, {:type => 'blips'})
    end
   respond_to do |format|
     format.js
     end
 end

  def buypitch
    @append = true if params[:lp_page].present?
    @user = User.find_by_id(params[:uid])
    if @user.present?
      @pitchs = get_records(@user.pitches.buy_pitch, params, {:type => 'longpitchs'})
    else
      @buypitchs = nil
    end
    respond_to do |format|
      format.js
    end
  end

  def sellpitch
    @append = true if params[:sp_page].present?
    @user = User.find_by_id(params[:uid])
    if @user.present?
      @pitchs = get_records(@user.pitches.sell_pitch, params, {:type => 'shortpitchs'})
    end
    respond_to do |format|
      format.js
    end
  end

  def question
    @user = User.find_by_id(params[:uid])
    if @user.present?
      @questions = get_objects(@user.questions, params)
    end
    respond_to do |format|
      format.js
    end
  end

  def answer
    @user = User.find_by_id(params[:uid])
    if @user.present?
      @answers = get_objects(@user.answers, params)
    end
    respond_to do |format|
      format.js
    end
  end

  def comment
    @user = User.find_by_id(params[:uid])
    if @user.present?
      @comments = get_objects(@user.comments, params)
    end
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
    # Below code is for range option, no longer used
    # params[:range] = 10 if params[:range].blank?
    # obj_relationship.order("created_at #{params[:sort_by]}").where("created_at between '#{Date.today - params[:range].to_i}' and '#{Date.today}'")
    obj_relationship.order("created_at #{params[:sort_by]}")

  end

end
