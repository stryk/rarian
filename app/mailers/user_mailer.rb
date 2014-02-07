class UserMailer < ActionMailer::Base
  # Sendgrid settings
  # include SendGrid
  # sendgrid_category :use_subject_lines
  # sendgrid_enable   :ganalytics, :opentrack
  
  default from: configatron.DEFAULT_EMAIL

  def send_follow_action(follower, followee)
  	@follower = follower
  	@followee = followee
  	mail(to: followee.email, subject: 'Someone started to follow you on AlphaPitch.com')
  end

  def send_answer_action(answer, answerer)
	@answer = answer
	@answerer = answerer
	@questioner = @answer.question.user
  	mail(to: @questioner.email, subject: 'Someone has answered the question you posted on AlphaPitch.com')
  end

  def send_comment_action(comment, commented_article)
  	@comment = comment
  	@commented_article = commented_article
  	mail(to: @commented_article.user.email, subject: 'Someone has left a comment on your contribution on AlphaPitch.com')
  end	

end
