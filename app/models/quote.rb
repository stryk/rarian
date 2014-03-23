class Quote < ActiveRecord::Base
	belongs_to :company
  validates :price, :date_time, presence: true

  def self.get_cap(params)
  	return_value = [] 
  	if params[:get] && params[:get] == 'small_cap'
  		company_ids = Quote.where('market_cap < 1 AND created_at > DATE(?)', Time.now - 3.days).order('company_id DESC').
      group('company_id').select('count(quotes.id), quotes.company_id').map(&:company_id)
      return_value = [company_ids, 'get']
    elsif params[:get] && params[:get] == 'mid_cap'
      company_ids = Quote.where('market_cap >= 1 and market_cap <= 10 AND created_at > DATE(?)', Time.now - 3.days).order('company_id DESC').
      group('company_id').select('count(quotes.id), quotes.company_id').map(&:company_id)
      return_value = [company_ids, 'get']
    elsif params[:get] && params[:get] == 'large_cap'
      company_ids = Quote.where('market_cap > 10 AND created_at > DATE(?)', Time.now - 3.days).order('company_id DESC').
      group('company_id').select('count(quotes.id), quotes.company_id').map(&:company_id)
      return_value = [company_ids, 'get']
    elsif params[:sector]
    	company_ids = Company.where(:sector => params[:sector]).to_a.map(&:id)
    	return_value = [company_ids, 'sector']
    elsif params[:industry]
    	company_ids = Company.where(:sector => params[:industry]).to_a.map(&:id)
    	return_value = [company_ids, 'industry']
    elsif params[:style]
      if params[:style] == 'value'
        group = 'Value'
      elsif params[:style] == 'growth'
        group = 'Growth'
      elsif params[:style] == 'momentum'
        group = 'Momentum'
      else
        group = 'Dividend Yield > 4'
      end
      company_ids = Group.find_by_name(group).companies.to_a.map(&:id)
      return_value = [company_ids, 'style']
    elsif params[:index]
      if params[:index] == 'snp500'
        group = 'S&P 500'
      elsif params[:index] == 'snp400'
        group = 'S&P 400'
      elsif params[:index] == 'snp600'
        group = 'S&P 600'
      else
        group = 'Nasdaq 100'
      end
      company_ids = Group.find_by_name(group).companies.to_a.map(&:id)
      return_value = [company_ids, 'index']
    else
      return_value = [[], '']
    end
    return_value
  end
end
