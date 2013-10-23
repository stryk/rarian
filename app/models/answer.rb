class Answer < ActiveRecord::Base

  attr_accessible :content, :user_id, :company_id, :question_id, :net_votes, :points

  module Point
    UP = 2
    DOWN = -2
  end

  belongs_to :user
  belongs_to :company
  belongs_to :question

  validates :content, :company_id, :user_id, :question_id, presence: true

  make_voteable

  acts_as_commentable

  def get_full_title
    content
  end

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
