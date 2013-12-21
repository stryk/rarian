class Pitch < ActiveRecord::Base
  attr_accessible :title, :multimedia_content, :action, :user_id, :company_id, :net_votes, :points

  module Point
    UP = 5
    DOWN = -5
  end

  validates :title, :multimedia_content, :company_id, :user_id, presence: true
  belongs_to :user
  belongs_to :company

  scope :buy_pitch, -> {where({:action => "buy"})}
  scope :sell_pitch, -> {where({:action => "sell"})}

  make_voteable

  acts_as_commentable

  def get_multimedia_content
    multimedia_content
  end

  def get_full_title
    title
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
end
