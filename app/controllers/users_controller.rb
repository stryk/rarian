class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_filter :load_user
  load_and_authorize_resource
  skip_authorize_resource :only => :show

  def show
    params[:sort_by] = 'desc' if params[:sort_by].blank?
    @buypitchs = get_records(@user.pitches.buy_pitch, params, {:type => 'longpitchs'})
    @sellpitchs = get_records(@user.pitches.sell_pitch, params, {:type => 'shortpitchs'})
    @blips = get_records(@user.blips, params, {:type => 'blips'})
    @questions = get_objects(@user.questions, params)
    @answers = get_objects(@user.answers, params)
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

  def admin
    @buypitchs = Pitch.where("action = 'buy'").order('published asc, created_at desc').paginate(:page => params[:buy_page], :per_page => 5)
    @sellpitchs = Pitch.where("action = 'sell'").order('created_at desc').paginate(:page => params[:sell_page], :per_page => 5)
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
    @bp_credit = 0
    @sp_credit = 0
    @blips_credit = 0
    @questions_credit = 0
    @answers_credit = 0
    @comp_credit = 0
    @risks_credit = 0
    @buy_pitches = current_user.pitches.buy_pitch
    @bp_credit = @buy_pitches.map(&:net_votes).inject{|sum,x| sum + x } if !@buy_pitches.blank?
    @sell_pitches = current_user.pitches.sell_pitch
    @sp_credit = @sell_pitches.map(&:net_votes).inject{|sum,x| sum + x } if !@sell_pitches.blank?
    @blips = current_user.blips
    @blips_credit = @blips.map(&:net_votes).inject{|sum,x| sum + x } if !@blips.blank?
    @questions = current_user.questions
    @questions_credit = @questions.map(&:net_votes).inject{|sum,x| sum + x } if !@questions.blank?
    @answers = current_user.answers
    @answers_credit = @answers.map(&:net_votes).inject{|sum,x| sum + x } if !@answers.blank?
    @competitors = current_user.competitors
    @comp_credit = @competitors.map(&:net_votes).inject{|sum,x| sum + x } if !@competitors.blank?
    @risks = current_user.risks
    @risks_credit = @risks.map(&:net_votes).inject{|sum,x| sum + x } if !@risks.blank?
    @credit_sum = (@bp_credit * 9) + (@sp_credit * 9) + (@blips_credit * 3) + (@questions_credit * 3) + (@answers_credit * 6) + @comp_credit + (@risks_credit * 2)

  end

  def update


  end

  def about

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

  def load_user
    if params[:id] == nil
      @user = nil
    else
      @user= User.friendly.find(params[:id].to_s.downcase)
    end
  end

end
