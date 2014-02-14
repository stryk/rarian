ThinkingSphinx::Index.define :user, :with => :active_record, :delta => ThinkingSphinx::Deltas::SidekiqDelta do
	indexes name
	set_property :enable_star => 1
  set_property :min_infix_len => 1
end