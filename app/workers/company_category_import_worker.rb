class CompanyCategoryImportWorker
	include Sidekiq::Worker
	sidekiq_options :retry => 3

	def perform(tempfile)
		tempfile = File.open(tempfile) rescue nil

		if tempfile.present?
			Company.all.each do |co|
				co.sector = "NA"
				co.industry = "NA"
				co.save
			end
			CSV.foreach(tempfile.path, headers: true) do |row|
				begin

					row_hash = row.to_hash
					if row_hash['Symbol'].present?
						company = Company.find_by(ticker: row_hash['Symbol'].gsub(/\^/, "-"))
						company = Company.find_by(ticker: row_hash['Symbol']) if company.blank?
						company = Company.new if company.blank?
						company.name = row_hash['Name'].gsub(/&#39;/, "'")
						company.ticker = row_hash['Symbol'].gsub(/\^/, "-")
						company.sector = row_hash['GICSSectors']
						company.industry = row_hash['GICSIndustries']

						key = 'S&P 500'
						if row_hash[key] == '1'
							group = Group.find_or_create_by(name: key)
							group.company_groups.find_or_create_by(:company_id => company.id, :name => "stock index")
						else
							if company.company_groups.find_by_name(key)
								company.company_groups.find_by_name(key).destroy
							end
						end

						key = 'S&P 400'
						if row_hash[key] == '1'
							group = Group.find_or_create_by(name: key)
							group.company_groups.find_or_create_by(:company_id => company.id, :name => "stock index")
						else
							if company.company_groups.find_by_name(key)
								company.company_groups.find_by_name(key).destroy
							end
						end

						key = 'S&P 600'
						if row_hash[key] == '1'
							group = Group.find_or_create_by(name: key)
							group.company_groups.find_or_create_by(:company_id => company.id, :name => "stock index")
						else
							if company.company_groups.find_by_name(key)
								company.company_groups.find_by_name(key).destroy
							end
						end

						key = 'Nasdaq 100'
						if row_hash[key] == '1'
							group = Group.find_or_create_by(name: key)
							group.company_groups.find_or_create_by(:company_id => company.id, :name => "stock index")
						else
							if company.company_groups.find_by_name(key)
								company.company_groups.find_by_name(key).destroy
							end
						end

						key = 'Growth'
						if row_hash[key] == '1'
							group = Group.find_or_create_by(name: key, description: 'S&P 1500 growth index')
							group.company_groups.find_or_create_by(:company_id => company.id, :name => "stock index")
						else
							if company.company_groups.find_by_name(key)
								company.company_groups.find_by_name(key).destroy
							end
						end

						key = 'Value'
						if row_hash[key] == '1'
							group = Group.find_or_create_by(name: key, description: 'S&P 1500 value index')

							group.company_groups.find_or_create_by(:company_id => company.id, :name => "stock index")
						else
							if company.company_groups.find_by_name(key)
								company.company_groups.find_by_name(key).destroy
							end
						end

						key = 'Momentum (3mos, 1Yr, and 3Yr)'
						if row_hash[key] == '1'
							group = Group.find_or_create_by(name: 'Momentum', description: 'Stocks that has been going up in price for last 3mos, 1 year, and 3 years')
							group.company_groups.find_or_create_by(:company_id => company.id, :name => "stock index")
						else
							if company.company_groups.find_by_name(key)
								company.company_groups.find_by_name(key).destroy
							end
						end

						key = 'Dividend Yield > 4'
						if row_hash[key] == '1'
							group = Group.find_or_create_by(name: key, description: 'Stocks that has historically yielded 4% or higher in dividends')
							group.company_groups.find_or_create_by(:company_id => company.id, :name => "stock index")
						else
							if company.company_groups.find_by_name(key)
								company.company_groups.find_by_name(key).destroy
							end
						end

						company.save!
					end
				rescue ActiveRecord::RecordNotSaved
					logger.info "Unable to save a row during company data import process"
					logger.info row
				end

				Company
			end
		end
	end
end					