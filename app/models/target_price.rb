class TargetPrice < ActiveRecord::Base

  attr_accessible :year, :target_price, :company_id, :user_id
  belongs_to :company

  validates :year, :target_price, :company_id, :user_id, presence: true

  validates :target_price, :numericality => {:greater_than => 0}

  after_save :identify_median
  after_destroy :identify_median


  def identify_median
    sorted = TargetPrice.where(:year => year, :company_id => company_id).map(&:target_price).sort
    len = sorted.length
    if len % 2 == 0 # if even
      median_value = (sorted[(len / 2) - 1] + sorted[len / 2]) / 2.0
    else
      median_value = sorted[(len - 1) / 2]
    end
    MedianTargetPrice.new_median(median_value, company_id, year)
  end
end
