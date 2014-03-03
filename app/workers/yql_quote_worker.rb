class YqlQuoteWorker
	include Sidekiq::Worker
	sidekiq_options :retry => 5

	def perform
		url = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quote%20where%20symbol%20in%20(%22YHOO%22%2C%22AAPL%22%2C%22GOOG%22%2C%22MSFT%22)&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
		url_part1 = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quote%20where%20symbol%20in%20("
		url_part2 = ")&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
		url_and = "%2C"
		companies_url = ""
		companies = Company.all.limit(100)
		count = Company.all.count
		batch = 100
		iteration = count 
		companies.each do |company|
			companies_url 
		end
		response = HTTParty.get(url)
		data = JSON.parse(response.body)
		if(data['query']['diagnostics']['url'][1]["error"] == nil)
			price = data['query']['results']['quote'][0]['LastTradePriceOnly']
		end
	end
end