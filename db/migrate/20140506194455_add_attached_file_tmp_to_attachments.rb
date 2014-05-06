class AddAttachedFileTmpToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :attached_file_tmp, :string
  end
end
