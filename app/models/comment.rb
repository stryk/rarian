class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  attr_accessible :title, :comment, :user_id

  validates :title, :comment, :user_id, presence: true

  belongs_to :commentable, :polymorphic => true

  default_scope -> { order('created_at ASC') }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user

  def slug_candidates
    [
      :title
    ]
  end

end
