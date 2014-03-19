class AddColumnsToQuotes < ActiveRecord::Migration
  def change
  	add_column :quotes, :dayshigh, :decimal, :default => 0.0
  	add_column :quotes, :dayslow, :decimal, :default => 0.0
  	add_column :quotes, :yearhigh, :decimal, :default => 0.0
  	add_column :quotes, :yearlow, :decimal, :default => 0.0
  	add_column :quotes, :change, :decimal, :default => 0.0
  	add_column :quotes, :volume, :decimal, :default => 0
  end
end
