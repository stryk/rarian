class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super
    resource.roles = params[:user][:roles] || ["standard"]
    #resource.name = params[:user][:name]
    #resource.mobilenumber = params[:user][:mobilenumber]
    resource.email_user_activity = true
    resource.email_comment = true
    resource.email_question = true
    resource.email_answer = true
    resource.email_company_activity = true
    resource.email_follow_me = true
    resource.email_answer_question = true
    resource.email_comment_reply = true
    resource.no_day_newsletter = 7

    resource.save
  end

  def update
    if params[:check_type] == 'email_user_activity' && !params[:email_user_activity].blank?
      resource.email_user_activity = true

    elsif params[:check_type] == 'email_user_activity'
      resource.email_user_activity = false
    end

    if params[:check_type] == 'email_comment' && !params[:email_comment].blank?
      resource.email_comment = true
      #raise email_comment.inspect
    elsif params[:check_type] == 'email_comment'
      resource.email_comment = false
    end

    if params[:check_type] == 'email_question' && !params[:email_question].blank?
      resource.email_question = true
      #raise resource.inspect
    elsif params[:check_type] == 'email_question'
      resource.email_question = false
    end

    if params[:check_type] == 'email_answer' && !params[:email_answer].blank?
      resource.email_answer = true
    elsif params[:check_type] == 'email_answer'
      resource.email_answer = false
    end

    if params[:check_type] == 'email_company_activity' && !params[:email_company_activity].blank?
      resource.email_company_activity = true
    elsif params[:check_type] == 'email_company_activity'
      resource.email_company_activity = false
    end

    if params[:check_type] == 'email_follow_me' && !params[:email_follow_me].blank?
      resource.email_follow_me = true
    elsif params[:check_type] == 'email_follow_me'
      resource.email_follow_me = false
    end

    if params[:check_type] == 'email_answer_question' && !params[:email_answer_question].blank?
      resource.email_answer_question = true
    elsif params[:check_type] == 'email_answer_question'
      resource.email_answer_question = false
    end

    if params[:check_type] == 'email_comment_reply' && !params[:email_comment_reply].blank?
      resource.email_comment_reply = true
    elsif params[:check_type] == 'email_comment_reply'
      resource.email_comment_reply = false
    end
    resource.no_day_newsletter = params[:user][:no_day_newsletter] if params[:user] && params[:user][:no_day_newsletter]

    resource.password = params[:user][:password] if params[:user] && params[:user][:password]
    resource.password_confirmation = params[:user][:password_confirmation] if params[:user] && params[:user][:password_confirmation]
    resource.mobilenumber = params[:user][:mobilenumber] if params[:user] && params[:user][:mobilenumber]
    resource.name = params[:user][:name] if params[:user] && params[:user][:name]
    resource.aboutuser = params[:user][:aboutuser] if params[:user] && params[:user][:aboutuser]
    resource.userinterest = params[:user][:userinterest] if params[:user] && params[:user][:userinterest]
    resource.company = params[:user][:company] if params[:user] && params[:user][:company]
    resource.blog = params[:user][:blog] if params[:user] && params[:user][:blog]




     if resource.save
       @msg = "sucessfuly updated"
       redirect_to root_path if params[:user] && params[:user][:password]
     else
       #raise resource.errors.full_messages.inspect
       @msg = "Failed to update"
       #return redirect_to '/users/setting'
     end
    respond_to do |format|
      format.html {}
      format.js {}
    end
   end



   def blips
     @blips = current_user.blips
   end

   def aboutuser

   end

   protected

    def after_inactive_sign_up_path_for(resource)
      root_path
    end

end
