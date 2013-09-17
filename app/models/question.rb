class Question < ActiveRecord::Base

  attr_accessible :content, :user_id, :company_id, :net_votes

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
    update_attributes(:net_votes => net_votes.to_i + 1)
  end

  def down_vote
    update_attributes(:net_votes => net_votes.to_i - 1)
  end

  def undo_vote(value)
    update_attributes(:net_votes => net_votes.to_i - value.to_i)
  end



end
