class AddImageTmpToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :image_tmp, :string
  end
end
