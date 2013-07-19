class Blip < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  ACTIONS = %w(buy sell)

  validates :action, :inclusion => {:in => ["buy", "sell"]}

  validates :content, :company_id, :user_id, presence: true

  validates_length_of :content, :minimum => 5, :maximum => 140, :allow_blank => false

  default_scope { order("created_at desc") }

  attr_accessible :action, :content, :quantity, :company_id, :user_id

  make_voteable

end
