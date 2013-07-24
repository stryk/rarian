# SendGrid
# ActionMailer::Base.smtp_settings = {
#   :address        => 'smtp.sendgrid.net',
#   :port           => '587',
#   :authentication => :plain,
#   :user_name      => SENDGRID_USERNAME,
#   :password       => SENDGRID_PASSWORD,
#   :domain         => 'heroku.com'
# }
# ActionMailer::Base.delivery_method = :smtp

# Amazon - comment out below if using sendgrid
ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
	:access_key_id     => ENV["AWS_ACCESS_KEY_ID"],
	:secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"]