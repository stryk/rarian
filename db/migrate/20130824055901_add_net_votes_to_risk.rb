class AddNetVotesToRisk < ActiveRecord::Migration
  def change
    add_column :risks, :net_votes, :integer, :limit => 2, :default => 0
    remove_column :competitors, :net_votes
    add_column :competitors, :net_votes, :integer, :limit => 2, :default => 0
  end
end
