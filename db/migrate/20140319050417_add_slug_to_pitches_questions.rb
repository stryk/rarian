class AddSlugToPitchesQuestions < ActiveRecord::Migration
  def change
  	add_column(:pitches, :slug, :string)
    add_index :pitches, :slug, unique: true
  	add_column(:questions, :slug, :string)
    add_index :questions, :slug, unique: true
  end
end
