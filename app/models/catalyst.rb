class Catalyst < ActiveRecord::Base
  attr_accessible :user_id, :company_id, :content, :date, :points

  belongs_to :user

  module Point
    UP = 1
    DOWN = -1
  end

  validates :content, :date, :company_id, :user_id, presence: true

  def up_vote
    update_attributes(:net_votes => net_votes.to_i + 1, :points => points.to_i+Point::UP)
  end

  def down_vote
    update_attributes(:net_votes => net_votes.to_i - 1, :points => points.to_i+Point::DOWN)
  end

  def undo_vote(value)
    undo_point = value > 0 ? Point::DOWN : Point::UP
    update_attributes(:net_votes => net_votes.to_i - value.to_i, :points => points.to_i+undo_point)
  end
end
