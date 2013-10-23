class AddColumnPointsToMainTables < ActiveRecord::Migration
  def change
    add_column(:blips, :points, :integer, :default => 0)
    add_column(:pitches, :points, :integer, :default => 0)
    add_column(:questions, :points, :integer, :default => 0)
    add_column(:answers, :points, :integer, :default => 0)
    add_column(:catalysts, :points, :integer, :default => 0)
    add_column(:risks, :points, :integer, :default => 0)
  end
end
