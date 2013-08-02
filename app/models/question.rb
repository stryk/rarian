class Question < ActiveRecord::Base

  attr_accessible :content, :user_id, :company_id

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



end
