class CleanUpS3objectsWorker
	include Sidekiq::Worker
	sidekiq_options :retry => 5

	def perform(bucket_name, key)
		s3 = AWS::S3.new
	    bucket = s3.buckets[bucket_name]
	    obj = bucket.objects[key]
	    if obj.exists?
	    	obj.delete
	    end
	end
end
