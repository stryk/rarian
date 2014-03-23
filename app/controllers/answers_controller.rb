class AnswersController < ApplicationController

  before_filter :load_company_and_question
  load_and_authorize_resource

  def new

  end

  def create
    @answer = @question.answers.create(:user_id => current_user.id,
                             :company_id => @company.id,
                             :content => params[:answer][:content])
    if @answer.errors.blank?
      #flash[:notice] = "Successfully added the answer"
      @msg = "Successfully added the answer"
      EmailAnswerActionWorker.perform_async(@answer.id, current_user.id)
      #redirect_to company_path(@company)
      respond_to do |format|
        format.js
      end
    else
      #flash[:error] = @answer.errors.full_messages.join(",")
      @msg = @answer.errors.full_messages.join(",")
      render :new, :company_id => params[:company_id], :question_id => params[:question_id]
    end
  end

  def update
    @answer.offloaded = false
    @answer.update_attributes(:content => params[:answer][:content])
    if @answer.errors.blank?
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    deleted_answer = Answer.where(:id => params[:id]).last
    @deleted_answer_id = deleted_answer.id
    deleted_answer.destroy
    respond_to do |format|
      format.js {render 'destroy'}
    end
  end

  private
  def load_company_and_question
    @company= Company.friendly.find((params[:company_id]).downcase)
    @question= Question.find_by_id(params[:question_id])
  end


end
