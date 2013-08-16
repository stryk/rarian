class CreateTopUsers < ActiveRecord::Migration
  def change
    create_table :top_users do |t|
      t.integer :user_id
      t.integer :no_of_up_votes
      t.integer :no_of_down_votes
      t.integer :no_of_votes, :limit => 2
      t.timestamps
    end
  end
end
