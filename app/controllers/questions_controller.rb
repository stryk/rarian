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

  private

  def load_company
    @company= Company.find(params[:company_id])
  end
end
