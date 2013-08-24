class Competitor < ActiveRecord::Base
  belongs_to :competitor_company, :foreign_key => :competitor_id, :class_name => "Company"
  belongs_to :company
  belongs_to :user

  make_voteable

  attr_accessible :company_id, :user_id, :competitor_id, :net_votes

  validates :competitor_id, :company_id, :user_id, presence: true

  def self.get_competitors(company)
    where(:company_id => company.id).select("id, company_id, competitor_id, user_id, net_votes").order("net_votes DESC")
  end

  def get_full_title
    "(" + "#{net_votes.to_i}" +")" + " : " + "#{competitor_company.try(:name)}"
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
end
