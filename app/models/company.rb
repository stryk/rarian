class Company < ActiveRecord::Base

  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  validates :ticker, :name, presence: true
  validates_length_of :description, :maximum => 500, :allow_blank => true
  has_many :quotes
  has_many :blips
  has_many :pitches
  has_many :questions
  has_many :answers
  has_many :most_active_tickers
  has_many :competitors
  has_many :risks
  has_many :target_prices
  has_many :company_groups
  has_many :groups, through: :company_groups
  has_many :attachments
  attr_accessible :ticker, :name, :slug
  acts_as_followable
  self.per_page = 30

	def self.import(file, exchange, date)
		#  checking file signature to prevent duplicates from uploading
		signature = Digest::SHA1.file(file.path).hexdigest
		same_file = QuoteImport.find_by(signature: signature)
		unless same_file.present?
			CSV.foreach(file.path, headers: true) do |row|
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
			new_file.filename = file.original_filename
			new_file.save
		end
  end

  def last_and_previous_closing_price
    quotes.order("date_time DESC").limit(2)
  end

  def last_price
  	if quotes.present?
  		quotes.last.price
  	else
  		0
  	end
  end


	def slug_candidates
		[
			:ticker,
			[:ticker, :exchange],
			[:ticker, :exchange, :id]
		]
    end


end
