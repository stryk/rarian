class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :ticker
      t.string :exchange
      t.boolean :active
      t.integer :ipo_year
      t.string :sector
      t.string :industry
      t.string :website_url
      t.text :description

      t.timestamps
    end

    add_index :companies, :name
    add_index :companies, :ticker
    add_index :companies, :exchange
    add_index :companies, :active
    add_index :companies, :ipo_year
    add_index :companies, :sector
    add_index :companies, :industry
  end
end
