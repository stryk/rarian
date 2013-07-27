class CommentsController < ApplicationController
  load_and_authorize_resource
  after_filter :flash_to_headers, only: [:create]

  def index
    @comment_obj = get_comment_on_obj
  end

  def create
    comment_obj = get_comment_on_obj
    @comment = comment_obj.comments.create(:comment => params[:comment][:comment],
                                    :user_id => current_user.id)
    if !@comment.errors.full_messages.blank?
      flash[:error] = @comment.errors.full_messages
    else
      flash[:notice] = "Comment Created Successfully"
    end
  end

  def get_comment_on_obj
    if !params[:blip_id].blank?
      Blip.where(:id => params[:blip_id]).last
    elsif !params[:pitch_id].blank?
      Pitch.where(:id =>  params[:pitch_id]).last
    end
  end
end
