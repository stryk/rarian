ThinkingSphinx::Index.define :company, :with => :active_record do
  indexes name, :sortable => true
  indexes ticker
  set_property :enable_star => 1
  set_property :min_infix_len => 1
  # indexes blips.content, :as => :blip_content
  # indexes pitches.title, :as => :pitche_title
  # indexes questions.content, :as => :question_content
  # indexes answers.content, :as => :answer_content
end