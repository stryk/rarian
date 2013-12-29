class QuestionsController < ApplicationController

  before_filter :load_company
  load_and_authorize_resource
  after_filter :flash_to_headers, only: [:create]

  def create
    @question = current_user.questions.create(params[:question].merge(:company_id => @company.id))
    if !@question.errors.blank?
      flash[:error] = @question.errors.full_messages
    else
      flash[:notice] = "Question Created Successfully"
    end
  end

   def update
    @question.update_attributes(params[:question])
    if @question.errors.blank?
      respond_to do |format|
        format.js
      end
    end

  end

  def destroy
    deleted_question = Question.where(:id => params[:id]).last
    @deleted_question_id = deleted_question.id
    deleted_question.destroy
    respond_to do |format|
      format.js {render 'destroy'}
    end
  end

  private

  def load_company
    @company= Company.friendly.find((params[:company_id]).downcase)
  end
end
