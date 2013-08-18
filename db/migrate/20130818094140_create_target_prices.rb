class CreateTargetPrices < ActiveRecord::Migration
  def change
    create_table :target_prices do |t|
      t.integer :company_id
      t.integer :user_id
      t.integer :year
      t.float :target_price

      t.timestamps
    end
  end
end
