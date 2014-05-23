class ChangeDatatypeOnTableFromStringToText < ActiveRecord::Migration
  def change
  	def up
    	change_column :users, :aboutuser, :text, :limit => 500
    	change_column :users, :userinterest, :text, :limit => 500
  	end
  	def down
  		change_column :users, :aboutuser, :string
  		change_column :users, :userinterest, :string
  	end
  end
end
