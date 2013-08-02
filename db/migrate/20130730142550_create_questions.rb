class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :content
      t.references :user, index: true
      t.references :company, index: true

      t.timestamps
    end
  end
end
