class AddSlugToPitchesQuestions < ActiveRecord::Migration
  def change
  	add_column(:pitches, :slug, :string)
    add_index :pitches, :slug, unique: true
  	add_column(:questions, :slug, :string)
    add_index :questions, :slug, unique: true
    Pitch.all.each do |p|
    	p.save
    end
    Question.all.each do |q|
    	q.save
    end
  end
end
