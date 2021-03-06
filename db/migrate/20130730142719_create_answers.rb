class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :content
      t.references :user, index: true
      t.references :company, index: true
      t.references :question, index: true

      t.timestamps
    end
  end
end
