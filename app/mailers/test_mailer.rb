class TestMailer < ActionMailer::Base
  default from: "dev@example.com"

  def test_email(user)
  	@user = user
  	mail(to: "dankim418@gmail.com", subject: 'Testing email function')
  end
end
