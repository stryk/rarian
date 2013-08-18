class CreateMedianTargetPrices < ActiveRecord::Migration
  def change
    create_table :median_target_prices do |t|
      t.integer :company_id
      t.integer :year
      t.float :price

      t.timestamps
    end
  end
end
