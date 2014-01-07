class MedianTargetPrice < ActiveRecord::Base

  attr_accessible :price, :year, :company_id

  validates :price, :year, :company_id, presence: true

  def self.two_year_price(company_id)
    where(:year => [Date.today.year, Date.today.year+1], :company_id => company_id).order("year ASC")
  end


  def self.new_median(price, company_id, year)
    median_target_price = where(:year => year, :company_id => company_id).first_or_initialize(:price => price)
    median_target_price.new_record? ? median_target_price.save : median_target_price.update_attributes(:price => price)
  end
end
