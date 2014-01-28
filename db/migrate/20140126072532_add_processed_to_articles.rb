class AddProcessedToArticles < ActiveRecord::Migration
  def change
  	add_column(:pitches, :offloaded, :boolean, :default => false)
  	add_column(:answers, :offloaded, :boolean, :default => false)
  end
end
