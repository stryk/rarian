class AddScanTimestampToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :scan_timestamp, :datetime
    add_column :attachments, :scan_provider, :string
    add_column :attachments, :scan_id, :string
    add_index :attachments, [:scan_timestamp, :scan_provider]
    add_index :attachments, :scan_id
  end
end
