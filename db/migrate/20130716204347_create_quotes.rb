class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.datetime :date_time
      t.boolean :closing
      t.decimal :price
      t.decimal :market_cap
      t.integer :company_id

      t.timestamps
    end

    add_index :quotes, :date_time
    add_index :quotes, :price
    add_index :quotes, :market_cap
  end
end
