class YqlQuoteWorker
	include Sidekiq::Worker
  	include Sidetiq::Schedulable
	sidekiq_options :retry => false

	recurrence do
		minute_hand = []
		0.step(50,10) {|num| minute_hand << num}
		weekly(1).day(1,2,3,4,5).hour_of_day(10, 18).minute_of_hour(minute_hand)
	end 
	def perform
		if configatron.AUTO_QUOTE_UPDATE == true
			10.times do
				url_part1 = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quote%20where%20symbol%20in%20("
				url_part2 = ")&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
				url_and = "%2C"
				companies_url = ""
				batch = 100
				companies = Company.order(:quote_updated_at =>:asc).limit(batch) 
				companies.each do |company|
					companies_url = companies_url + "%22" + company.ticker.gsub(/\^/, "-") + "%22" + url_and
				end
				companies_url = companies_url[0..-4]
				url = url_part1 + companies_url + url_part2
				response = HTTParty.get(url.gsub(/\s+/, ""))
				data = JSON.parse(response.body)

				if(data['query']['diagnostics']['url'][1]["error"] == nil)
					companies.each do |company|
						index = companies.index(company)
						today_quote = company.quotes.where('created_at = DATE(?)', Time.now).last
						if today_quote.present?
							quote = today_quote
						else
							quote = company.quotes.build
						end
						quote.price = data['query']['results']['quote'][index]['LastTradePriceOnly']
						quote.closing = (Time.now.hour >= 16)
						quote.date_time = Time.now
						market_cap = data['query']['results']['quote'][index]['MarketCapitalization']
						if(market_cap.present? && (market_cap.include? 'B'))
							quote.market_cap = market_cap.gsub("B","").to_f
						elsif(market_cap.present? && (market_cap.include? 'M'))
							quote.market_cap = market_cap.gsub("M","").to_f / 1000
						end
						quote.dayslow = data['query']['results']['quote'][index]['DaysLow']
						quote.dayshigh = data['query']['results']['quote'][index]['DaysHigh']
						quote.yearlow = data['query']['results']['quote'][index]['YearLow']
						quote.yearhigh = data['query']['results']['quote'][index]['YearHigh']
						quote.volume = data['query']['results']['quote'][index]['Volume']
						quote.change = data['query']['results']['quote'][index]['Change']
						company.quote_updated_at = quote.date_time
						quote.save
						company.save
					end
				else
					raise('Request did not succeed!')
				end
			end
		end
	end
end