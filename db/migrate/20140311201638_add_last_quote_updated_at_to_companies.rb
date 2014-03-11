class AddLastQuoteUpdatedAtToCompanies < ActiveRecord::Migration
  def change
  	add_column :companies, :quote_updated_at, :datetime, :default => Time.now
  	add_index :companies, :quote_updated_at
  end
end
