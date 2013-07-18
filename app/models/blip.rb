class Blip < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  validates :action, :inclusion => { :in => ["buy", "sell"] }

  default_scope { order("created_at desc") }
end
