class UserMailerPreview < ActionMailer::Preview

  def send_follow_action
  	UserMailer.send_follow_action(User.last,User.first)
  end

  def send_answer_action
  	UserMailer.send_answer_action(Answer.last, Answer.last.user)
  end

  def send_comment_action(comment, commented_article)
  	comment = Comment.last
  	commented_article = comment.commentable
  	UserMailer.send_comment_action(comment, commented_article)
  end	

end