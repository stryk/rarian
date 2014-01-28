class CreateS3objects < ActiveRecord::Migration
  def change
    create_table :s3objects do |t|
    	t.string :key
    	t.string :bucket
    	t.string :checksum
    	t.string :storable_type
    	t.integer :storable_id
    end
  end
end
