class AddColumnNetVotesToVotableTables < ActiveRecord::Migration
  def change
    add_column(:pitches, :net_votes, :integer, :limit => 2, :default => 0)
    add_column(:questions, :net_votes, :integer, :limit => 2, :default => 0)
    add_column(:answers, :net_votes, :integer, :limit => 2, :default => 0)
    add_column(:blips, :net_votes, :integer, :limit => 2, :default => 0)
  end
end
