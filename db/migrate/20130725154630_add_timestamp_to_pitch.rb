class AddTimestampToPitch < ActiveRecord::Migration
  def change
    change_table :pitches do |t|
      t.timestamps
    end
  end
end
