ThinkingSphinx::Index.define :company, :with => :active_record, :delta => true do
  indexes name
  indexes ticker
  indexes blips.content, :as => :blip_content
  indexes pitches.title, :as => :pitche_title
  indexes questions.content, :as => :question_content
  indexes answers.content, :as => :answer_content
end