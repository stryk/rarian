class CommentsController < ApplicationController
  load_and_authorize_resource
  after_filter :flash_to_headers, only: [:create]

  def index
    @comment_obj = get_comment_on_obj

  end

  def create
    @comment_obj = get_comment_on_obj
    @comment = @comment_obj.comments.create(:comment => params[:comment][:comment],
                                    :user_id => current_user.id)
    if !@comment.errors.full_messages.blank?

      flash[:error] = @comment.errors.full_messages
    else
      unless(@comment_obj.user.id == @current_user.id)
        EmailCommentActionWorker.perform_async(@comment.id)
      end
      respond_to do |format|
        format.js
      end
    end
  end

  def update
    @comment.update_attributes(:comment => params[:comment][:comment])
    @commentable_obj = @comment.commentable
    if @comment.errors.blank?
      #flash[:notice] = "Successfully added the reason"
      @msg = "Update complete."
      #redirect_to company_path(@company)
      respond_to do |format|
        format.js
      end
    end

  end

  def destroy
    deleted_comment = Comment.where(:id => params[:id]).last
    @deleted_comment_id = deleted_comment.id
    @commentable_obj = deleted_comment.commentable
    deleted_comment.destroy
    respond_to do |format|
      format.js {render 'destroy'}
    end
  end

  def get_comment_on_obj
    if !params[:blip_id].blank?
      @blip_div = 'comments-alphablip-container'
      Blip.where(:id => params[:blip_id]).last
    elsif !params[:pitch_id].blank?
      Pitch.friendly.find(params[:pitch_id])
    elsif !params[:answer_id].blank?
      Answer.where(:id =>  params[:answer_id]).last
    elsif !params[:question_id].blank?
      Question.where(:id =>  params[:question_id]).last
    end
  end
end
