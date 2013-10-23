class AddAboutuserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :aboutuser, :string
  end
end
