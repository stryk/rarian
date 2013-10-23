class ChangeMobileNumberTypeToNumeric < ActiveRecord::Migration
  def self.up
    change_column(:users, :mobilenumber, :bigint)
  end

  def self.down
    change_column(:users, :mobilenumber, :integer)
  end
end
