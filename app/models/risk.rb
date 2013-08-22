class Risk < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  attr_accessible :company_id, :user_id, :risk

  validates :risk, :company_id, :user_id, presence: true
end
