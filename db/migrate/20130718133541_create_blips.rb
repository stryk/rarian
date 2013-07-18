class CreateBlips < ActiveRecord::Migration
  def change
    create_table :blips do |t|
      t.references :user, index: true
      t.references :company, index: true
      t.string :action
      t.text :content
      t.integer :quantity

      t.timestamps
    end
  end
end
