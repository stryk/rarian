class QuotesCleanupWorker
	include Sidekiq::Worker
  	include Sidetiq::Schedulable
	sidekiq_options :retry => 5

	recurrence do
		weekly(1).day(1,2,3,4,5).hour_of_day(2)
	end 
	def perform
		 Quote.where("created_at < ? AND (closing IS NULL OR closing = false)", Time.now - 7.days).destroy_all
		 quotes_to_keep = []
		 for i in 2..7
		 	Company.all.each do |company|
		 		if company.quotes.present?
		 			item = company.quotes.where("DATE(created_at) = DATE(?) AND closing = true", Time.now - i.days).order('created_at ASC').select(:id).last
		 			quotes_to_keep << item if item.present?
		 		end
		 	end
		 end
		 Quote.where("created_at > ?", Time.now - 7.days).destroy_all(['id NOT IN (?)', quotes_to_keep.map(&:id)])
	end
end