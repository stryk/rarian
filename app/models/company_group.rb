class CompanyGroup < ActiveRecord::Base
	attr_accessible :name, :company_id, :group_id
	validates :name, :company_id, :group_id, presence: true
	validates :company_id, :uniqueness => { :scope => :group_id }
	belongs_to :company
	belongs_to :group
end
