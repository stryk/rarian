class CreateCompetitors < ActiveRecord::Migration
  def change
    create_table :competitors do |t|
      t.integer :user_id
      t.integer :company_id
      t.integer :competitor_id
      t.integer :net_votes

      t.timestamps
    end
  end
end
