class CleanUpS3objectsWorker
	include Sidekiq::Worker

	def perform(bucket_name, key)
		s3 = AWS::S3.new
	    bucket = s3.buckets[bucket_name]
	    obj = bucket.objects[key]
	    obj.delete
	end
end
