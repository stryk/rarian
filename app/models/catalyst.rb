class Catalyst < ActiveRecord::Base
  attr_accessible :user_id, :company_id, :content, :date
end
