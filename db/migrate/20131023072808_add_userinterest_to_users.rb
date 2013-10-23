class AddUserinterestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :userinterest, :string
  end
end
