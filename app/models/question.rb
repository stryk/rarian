class Question < ActiveRecord::Base

  attr_accessible :content, :user_id, :company_id, :net_votes, :points

  module Point
    UP = 2
    DOWN = -2
  end

  belongs_to :user
  belongs_to :company
  has_many :answers

  validates :content, :company_id, :user_id, presence: true

  default_scope -> { order('created_at DESC') }

  make_voteable

  acts_as_commentable

  def get_full_title
    content
  end

  def child_link_name
    "Answer this"
  end

  def get_child_link
    "new_company_question_answer_path"
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
