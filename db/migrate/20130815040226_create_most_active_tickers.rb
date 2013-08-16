class CreateMostActiveTickers < ActiveRecord::Migration
  def change
    create_table :most_active_tickers do |t|
      t.integer :company_id
      t.integer :no_of_up_votes
      t.integer :no_of_down_votes
      t.integer :no_of_votes, :limit => 2
      t.date :active_date
      t.timestamps
    end
  end
end
