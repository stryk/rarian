class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :description
      t.integer :company_id
      t.integer :user_id
      t.integer :attachable_id
      t.string :attachable_type
      t.string :file_type
      t.integer :file_size_in_kb
      t.string :file_name
      t.string :attached_file

      t.timestamps
    end
    add_index :attachments, :company_id
    add_index :attachments, :user_id
    add_index :attachments, [:attachable_id, :attachable_type]
    add_index :attachments, :file_type
    add_index :attachments, :file_name
  end
end
