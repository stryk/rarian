class CreateQuoteImports < ActiveRecord::Migration
  def change
    create_table :quote_imports do |t|
      t.string :filename
      t.string :signature

      t.timestamps
    end
  end
end
