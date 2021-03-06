class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  attr_accessible :title, :comment, :user_id

  validates :comment, :user_id, presence: true
  validates_length_of :comment, :maximum => 500, :allow_blank => true
  belongs_to :commentable, :polymorphic => true

  default_scope -> { order('created_at ASC') }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user
  self.per_page = 10

  def get_full_title
    "<a href='/users/#{user.id}'>"+user.name+'</a>'+' '+title
  end

end
