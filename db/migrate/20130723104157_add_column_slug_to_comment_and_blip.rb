class AddColumnSlugToCommentAndBlip < ActiveRecord::Migration
  def change
    add_column(:comments, :slug, :string)
    add_column(:blips, :slug, :string)
    add_index :comments, :slug, unique: true
    add_index :blips, :slug, unique: true
  end
end
