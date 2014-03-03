class Competitor < ActiveRecord::Base
  before_create :not_duplicative_competitor
  belongs_to :competitor_company, :foreign_key => :competitor_id, :class_name => "Company"
  belongs_to :company
  belongs_to :user
  module Point
    UP = 1
    DOWN = -1
  end

  make_voteable

  attr_accessible :company_id, :user_id, :competitor_id, :net_votes

  validates :competitor_id, :company_id, :user_id, presence: true
  self.per_page = 10

  def self.get_competitors(company)
    where(:company_id => company.id).select("id, company_id, competitor_id, user_id, net_votes").order("net_votes DESC")
  end

  def get_full_title
    "<a href='/companies/#{competitor_company.slug}'>"+competitor_company.ticker.upcase+'</a>'+' '+"#{competitor_company.try(:name).truncate(20)}"
  end

  def up_vote
    update_attributes(:net_votes => net_votes.to_i + 1)
  end

  def down_vote
    update_attributes(:net_votes => net_votes.to_i - 1)
  end

  def undo_vote(value)
    update_attributes(:net_votes => net_votes.to_i - value.to_i)
  end

  def not_duplicative_competitor
    if company.competitors.where(:competitor_id => competitor_id).present?
      errors.add(:competition_exists, "Already in the competitor list.")
      return false
    end
  end
end
