class AddColumnVoteableToPitch < ActiveRecord::Migration
  def change
    add_column :pitches, :up_votes, :integer, :null => false, :default => 0
    add_column :pitches, :down_votes, :integer, :null => false, :default => 0
  end
end
