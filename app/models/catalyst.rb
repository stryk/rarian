class Catalyst < ActiveRecord::Base
  attr_accessible :user_id, :company_id, :content, :date

  validates :content, :date, :company_id, :user_id, presence: true
end
