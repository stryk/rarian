class Risk < ActiveRecord::Base
  belongs_to :company
  belongs_to :user

  make_voteable

  attr_accessible :company_id, :user_id, :risk, :net_votes

  validates :risk, :company_id, :user_id, presence: true

  def get_full_title
    risk
  end

  def up_vote
    update_attributes(:net_votes => net_votes.to_i + 1)
  end

  def down_vote
    update_attributes(:net_votes => net_votes.to_i - 1)
  end
end
