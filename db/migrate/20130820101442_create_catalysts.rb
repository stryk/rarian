class CreateCatalysts < ActiveRecord::Migration
  def change
    create_table :catalysts do |t|
      t.integer :user_id
      t.integer :company_id
      t.text :content
      t.date :date

      t.timestamps
    end
  end
end
