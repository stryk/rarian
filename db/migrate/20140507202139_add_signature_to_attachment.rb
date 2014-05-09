class AddSignatureToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :signature, :string
    add_column :attachments, :scanned, :bool
    add_index :attachments, :signature
  end
end
