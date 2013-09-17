class Answer < ActiveRecord::Base

  attr_accessible :content, :user_id, :company_id, :question_id, :net_votes

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
    update_attributes(:net_votes => net_votes.to_i + 1)
  end

  def down_vote
    update_attributes(:net_votes => net_votes.to_i - 1)
  end

  def undo_vote(value)
    update_attributes(:net_votes => net_votes.to_i - value.to_i)
  end

end
