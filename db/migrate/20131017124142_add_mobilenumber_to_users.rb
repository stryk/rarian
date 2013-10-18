class AddMobilenumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mobilenumber, :integer
  end
end
