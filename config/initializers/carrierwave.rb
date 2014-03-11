CarrierWave.configure do |config|
	config.fog_credentials = {
		provider: "AWS",
		aws_access_key_id: configatron.AWS_ACCESS_KEY_ID,
		aws_secret_access_key: configatron.AWS_SECRET_ACCESS_KEY
	}
	config.fog_directory = configatron.AWS_S3_BUCKET
end