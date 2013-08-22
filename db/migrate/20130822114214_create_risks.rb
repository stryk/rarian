class CreateRisks < ActiveRecord::Migration
  def change
    create_table :risks do |t|
      t.integer :company_id
      t.integer :user_id
      t.string :risk

      t.timestamps
    end
  end
end
