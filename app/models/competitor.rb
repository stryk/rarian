class Competitor < ActiveRecord::Base
  belongs_to :competitor_company, :foreign_key => :competitor_id, :class_name => "Company"
  belongs_to :company
  belongs_to :user
  attr_accessible :company_id, :user_id, :competitor_id

  validates :competitor_id, :company_id, :user_id, presence: true

  def self.get_competitors(company, no_of_compititors = 5)
    competitor_ids = where(:company_id => company.id).map(&:competitor_id)
    MostActiveTicker.where(:company_id => competitor_ids).
      order("no_of_votes DESC").
      limit(no_of_compititors).joins(:company).select("companies.id, companies.name, no_of_votes")
  end

end
