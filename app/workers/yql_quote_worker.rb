class YqlQuoteWorker
	include Sidekiq::Worker
  	include Sidetiq::Schedulable
	sidekiq_options :retry => 5

	recurrence do
		minute_hand = []
		0.step(55,5) {|num| minute_hand << num}
		daily.hour_of_day(9, 10, 11, 12, 13, 14, 15, 16, 17).minute_of_hour(minute_hand)
	end 
	def perform
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
					quote = company.quotes.build
					quote.price = data['query']['results']['quote'][index]['LastTradePriceOnly']
					quote.closing = (Time.now.hour >= 16)
					quote.date_time = Time.now
					quote.market_cap = data['query']['results']['quote'][index]['MarketCap']
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