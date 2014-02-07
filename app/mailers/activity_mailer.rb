class ActivityMailer < ActionMailer::Base
  default from: configatron.DEFAULT_EMAIL

  def test_email(user)
  	@user = user
  	mail(to: "dankim418@gmail.com", subject: 'Testing email function')
  end

end
