class Group < ActiveRecord::Base
	attr_accessible :name, :description
	validates :name, presence: true
	has_many :company_groups
	has_many :companies, through: :company_groups
end
