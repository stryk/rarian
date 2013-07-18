class Blip < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  default_scope { order("created_at desc") }
end
