class AddTablePitch < ActiveRecord::Migration
  def change
    create_table :pitches do |t|
      t.string :action
      t.text :multimedia_content
      t.references :user
      t.references :company
      t.string :title
    end

  end
end
