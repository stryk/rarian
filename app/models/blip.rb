class Blip < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  ACTIONS = %w(buy sell)

  validates :action, :inclusion => {:in => ["buy", "sell"]}

  validates :content, :company_id, :user_id, presence: true

  validates_length_of :content, :minimum => 5, :maximum => 140, :allow_blank => false

  default_scope { order("created_at desc") }

  attr_accessible :action, :content, :quantity, :company_id, :user_id, :net_votes

  make_voteable

  acts_as_commentable

  def get_full_title
    company.ticker+": "+created_at.strftime("%m/%d/%Y")+": "+action+": "+content
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
