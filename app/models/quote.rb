class Quote < ActiveRecord::Base
	belongs_to :company
  validates :price, :date_time, presence: true

  def self.get_cap(cap_type)
  	if cap_type == 'small_cap'
  		company_ids = Quote.where('market_cap < 1000000000').order('company_id DESC').
      group('company_id').select('count(quotes.id), quotes.company_id').map(&:company_id)
    elsif cap_type == 'mid_cap'
      company_ids = Quote.where('market_cap >= 1000000000 and market_cap <= 10000000000').order('company_id DESC').
      group('company_id').select('count(quotes.id), quotes.company_id').map(&:company_id)
    elsif cap_type == 'large_cap'
      company_ids = Quote.where('market_cap > 10000000000').order('company_id DESC').
      group('company_id').select('count(quotes.id), quotes.company_id').map(&:company_id)
    else
      company_ids = []
    end
  end
end
