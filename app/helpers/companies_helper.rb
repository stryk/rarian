module CompaniesHelper
  def up_voted_by_current_user(obj)
  (current_user && current_user.up_voted?(obj)) ? '<i class="icon-thumbs-up"></i> Upvoted(undo)' :
    (current_user && current_user.voted?(obj) ? '' :'<i class="icon-thumbs-up"></i>Upvote')
  end

  def down_voted_by_current_user(obj)
  (current_user && current_user.down_voted?(obj)) ? '<i class="icon-thumbs-down"></i> Downvoted(undo)' :
    (current_user && current_user.voted?(obj) ? '' :'<i class="icon-thumbs-down"></i>')
  end
end
