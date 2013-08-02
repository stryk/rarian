class Pitch < ActiveRecord::Base
  attr_accessible :title, :multimedia_content, :action, :user_id, :company_id

  validates :title, :multimedia_content, :company_id, :user_id, presence: true

  belongs_to :user
  belongs_to :company

  scope :buy_pitch, -> {where({:action => "buy"})}
  scope :sell_pitch, -> {where({:action => "sell"})}

  make_voteable

  acts_as_commentable

  def get_full_title
    created_at.strftime("%m/%d/%Y")+": "+action+": "+title
  end
end
