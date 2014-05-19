class AddPublishedToPitches < ActiveRecord::Migration
  def change
    add_column :pitches, :published, :bool, :default => false
    add_column :pitches, :published_at, :datetime

    add_index :pitches, :published
    add_index :pitches, [:published, :published_at]

    Pitch.all.each do |pitch|
    	pitch.published = true
    	pitch.published_at = pitch.updated_at
    	pitch.save!
    end
  end
end
