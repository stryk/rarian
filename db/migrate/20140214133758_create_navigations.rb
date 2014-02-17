class CreateNavigations < ActiveRecord::Migration
  def change
    create_table :navigations do |t|
      t.string :name
      t.integer :parent_id
      t.string :url
      t.string :query_hashs
      t.string :model_name

      t.timestamps
    end
  end
end
