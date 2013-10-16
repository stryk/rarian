class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super
    resource.roles = params[:user][:roles]
    resource.name = params[:user][:name]
    resource.mobilenumber = params[:user][:mobilenumber]
    resource.save

  end

  def update
    if params[:check_type] == 'email_vote' && !params[:email_vote].blank?
      resource.email_vote = true

    elsif params[:check_type] == 'email_vote'
      resource.email_vote = false
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

    if params[:check_type] == 'email_spam' && !params[:email_spam].blank?
      resource.email_spam = true
    elsif params[:check_type] == 'email_spam'
      resource.email_spam = false
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

    if params[:check_type] == 'email_sends_message' && !params[:email_sends_message].blank?
      resource.email_sends_message = true
    elsif params[:check_type] == 'email_sends_message'
      resource.email_sends_message = false
    end
    resource.no_day_newsletter = params[:user][:no_day_newsletter] if params[:user] && params[:user][:no_day_newsletter]

    resource.password = params[:user][:password] if params[:user] && params[:user][:password]
    resource.password_confirmation = params[:user][:password_confirmation] if params[:user] && params[:user][:password_confirmation]
    resource.mobilenumber = params[:user][:mobilenumber] if params[:user] && params[:user][:mobilenumber]
    resource.name = params[:user][:name] if params[:user] && params[:user][:name]

     if resource.save
       flash[:notice] = "sucess"
     else
       #raise resource.errors.full_messages.inspect
       flash[:notice] = "Failed to update"
       #return redirect_to '/users/setting'
     end
    render :text => "ok"


  end


end