class CommentsController < ApplicationController
  load_and_authorize_resource
  after_filter :flash_to_headers, only: [:create]

  def index
    @blip = Blip.find(params[:blip_id])
  end

  def create
    blip = Blip.find(params[:blip_id])
    @comment = blip.comments.create(:title => params[:comment][:title],
                                    :comment => params[:comment][:comment],
                                    :user_id => current_user.id)
    if !@comment.errors.full_messages.blank?
      flash[:error] = @comment.errors.full_messages
    else
      flash[:notice] = "Comment Created Successfully"
    end
  end
end
