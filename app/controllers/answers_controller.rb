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
      #redirect_to company_path(@company)
    else
      #flash[:error] = @answer.errors.full_messages.join(",")
      @msg = @answer.errors.full_messages.join(",")
      render :new, :company_id => params[:company_id], :question_id => params[:question_id]
    end
  end

  private
  def load_company_and_question
    @company= Company.friendly.find(params[:company_id])
    @question= Question.find(params[:question_id])
  end
end
