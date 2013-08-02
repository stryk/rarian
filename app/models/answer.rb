class Answer < ActiveRecord::Base

  attr_accessible :content, :user_id, :company_id, :question_id

  belongs_to :user
  belongs_to :company
  belongs_to :question

  validates :content, :company_id, :user_id, :question_id, presence: true

  make_voteable

  acts_as_commentable

  def get_full_title
    content
  end

end
