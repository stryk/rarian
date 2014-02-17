class Quote < ActiveRecord::Base
	belongs_to :company
  validates :price, :date_time, presence: true

  def self.get_cap(params)
  	return_value = [] 
  	if params[:get] && params[:get] == 'small_cap'
  		company_ids = Quote.where('market_cap < 1000000000').order('company_id DESC').
      group('company_id').select('count(quotes.id), quotes.company_id').map(&:company_id)
      return_value = [company_ids, 'get']
    elsif params[:get] && params[:get] == 'mid_cap'
      company_ids = Quote.where('market_cap >= 1000000000 and market_cap <= 10000000000').order('company_id DESC').
      group('company_id').select('count(quotes.id), quotes.company_id').map(&:company_id)
      return_value = [company_ids, 'get']
    elsif params[:get] && params[:get] == 'large_cap'
      company_ids = Quote.where('market_cap > 10000000000').order('company_id DESC').
      group('company_id').select('count(quotes.id), quotes.company_id').map(&:company_id)
      return_value = [company_ids, 'get']
    elsif params[:sector]
    	company_ids = Company.where(:sector => params[:sector]).to_a.map(&:id)
    	return_value = [company_ids, 'sector']
    elsif params[:industry]
    	company_ids = Company.where(:sector => params[:industry]).to_a.map(&:id)
    	return_value = [company_ids, 'industry']
    else
      return_value = [[], '']
    end
    return_value
  end
end
