class TargetPrice < ActiveRecord::Base

  attr_accessible :year, :target_price, :company_id, :user_id

  validates :year, :target_price, :company_id, :user_id, presence: true

  validates :target_price, :numericality => true

  after_save :identify_median
  after_destroy :identify_median


  def identify_median
    sorted = TargetPrice.where(:year => year).map(&:target_price).sort
    len = sorted.length
    if len > 0
      median_value = (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
    else
      0
    end

    MedianTargetPrice.new_median(median_value, company_id, year)
  end
end
