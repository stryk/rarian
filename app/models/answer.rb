class Answer < ActiveRecord::Base

  before_save :sanitize_content
  attr_accessible :content, :user_id, :company_id, :question_id, :net_votes, :points

  module Point
    UP = 2
    DOWN = -2
  end

  belongs_to :user
  belongs_to :company
  belongs_to :question

  validates :content, :company_id, :user_id, :question_id, presence: true
  validates_length_of :content, :maximum => 10000, :allow_blank => false
  make_voteable

  acts_as_commentable

  def get_full_title
    "<a href='/users/#{user.id}'>"+user.name+'</a>'+' '+content
  end

  def get_reference
    "<a href='/users/#{user.id}'>"+user.name+'</a>'+' | '
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

  def sanitize_content
    if content
      ActionController::Base.helpers.sanitize content, tags: %w{p strong em u span ol li ul img}, attributes: %w{style color src alt}
    end
  end
end
