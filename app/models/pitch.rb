class Pitch < ActiveRecord::Base
  attr_accessible :title, :multimedia_content, :action, :user_id, :company_id, :net_votes

  validates :title, :multimedia_content, :company_id, :user_id, presence: true

  belongs_to :user
  belongs_to :company

  scope :buy_pitch, -> {where({:action => "buy"})}
  scope :sell_pitch, -> {where({:action => "sell"})}

  make_voteable

  acts_as_commentable

  def get_full_title
    created_at.strftime("%m/%d/%Y")+": "+action+": "+title
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
