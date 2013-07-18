class Quote < ActiveRecord::Base
  validates :price, :date_time, presence: true
end
