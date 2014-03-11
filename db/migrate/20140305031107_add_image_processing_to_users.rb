class AddImageProcessingToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :image_processing, :boolean
  end
end
