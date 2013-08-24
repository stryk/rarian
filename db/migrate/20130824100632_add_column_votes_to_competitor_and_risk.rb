class AddColumnVotesToCompetitorAndRisk < ActiveRecord::Migration
  def change
    add_column :competitors, :up_votes, :integer, :null => false, :default => 0
    add_column :competitors, :down_votes, :integer, :null => false, :default => 0

    add_column :risks, :up_votes, :integer, :null => false, :default => 0
    add_column :risks, :down_votes, :integer, :null => false, :default => 0
  end
end
