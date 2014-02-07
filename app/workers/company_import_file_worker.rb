class CompanyImportFileWorker
	include Sidekiq::Worker
	sidekiq_options :retry => 3

	def perform(tempfile_path, exchange, date)
		tempfile = File.open(tempfile_path) rescue nil
		if tempfile.present?
			#  checking file signature to prevent duplicates from uploading
			signature = Digest::SHA1.file(tempfile.path).hexdigest
			same_file = QuoteImport.find_by(signature: signature)
			unless same_file.present?
				CSV.foreach(tempfile.path, headers: true) do |row|
					begin
						row_hash = row.to_hash
						company = Company.find_by(ticker: row_hash['Symbol'], name: row_hash['Name'])
						company = Company.new if company.blank?
						company.name = row_hash['Name']
						company.ticker = row_hash['Symbol']
						company.exchange = exchange
						company.sector = row_hash['Sector']
						company.industry = row_hash['industry']
						quote = company.quotes.build
						quote.price = row_hash['LastSale'].to_d
						quote.market_cap = row_hash['MarketCap'].to_d
						quote.date_time = DateTime.civil_from_format(:local, date['year'].to_i, date['month'].to_i, date['day'].to_i)
						company.save!
						quote.save!
					rescue ActiveRecord::RecordNotSaved
						logger.info "Unable to save a row during company data import process."
						logger.info row
					end
				end
				new_file = QuoteImport.new
				new_file.signature = signature
				new_file.filename = File.basename(tempfile)
				new_file.save
				if File::exists?(tempfile)
				  File::delete(tempfile) rescue true
				end
			end
		end
	end
end