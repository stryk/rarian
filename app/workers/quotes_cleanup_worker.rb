class QuotesCleanupWorker
	include Sidekiq::Worker
  	include Sidetiq::Schedulable
	sidekiq_options :retry => false

	recurrence do
		weekly(1).day(1,2,3,4,5).hour_of_day(2)
	end 
	def perform
		 expiration = 5
		 count = Quote.where("DATE(created_at) < DATE(?)", Time.now - expiration.days).count
		 iteration = (count / 100).to_i
		 for i in 0..(iteration + 1) do
		 	Quote.where("DATE(created_at) < DATE(?)", Time.now - expiration.days).limit(100).destroy_all
		 end  # delete records older than 30 days
		 
		 # for i in 5..30
		 # 	Company.all.each do |company|
		 # 		if company.quotes.present?
		 # 			quotes_to_keep = []
		 # 			item = company.quotes.where("DATE(created_at) = DATE(?) AND closing = true", Time.now - i.days).order('created_at ASC').select(:id).last
		 # 			quotes_to_keep << item if item.present?
		 # 			while company.quotes.where("DATE(created_at) = DATE(?)", Time.now - i.days).limit(1).present? do
		 # 				company.quotes.where("DATE(created_at) = DATE(?)", Time.now - i.days).limit(100).destroy_all(['id NOT IN (?)', quotes_to_keep.map(&:id)])
		 # 			end
		 # 		end
		 # 	end
		 # end
	end
end