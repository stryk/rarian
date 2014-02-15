class Navigation < ActiveRecord::Base
	acts_as_tree
	attr_accessible :url, :name, :parent_id, :query_hashs, :model_name
	store :query_hashs, accessors: [ :group, :where ]

	def get_chidrens
		if self.query_hashs.blank?
			self.children
		else
			childrens = []
			if self.query_hashs[:group]
				childrens = self.model_name.constantize.group(self.query_hashs[:group])
			end

			if self.query_hashs[:select] && self.query_hashs[:group]
				childrens = childrens.select(self.query_hashs[:select])
			elsif self.query_hashs[:select]
				childrens = self.model_name.constantize.select(self.query_hashs[:select])
			end

			childrens
		end
	end

	def should_generate_url?
		query_hashs.blank?
	end

	def generate_url(child_nav)
		if child_nav.is_a?(Navigation)
			child_nav.url.gsub(':name', name)
		else
			return url.gsub(':name', name) if url.include?(':name')
			return url.gsub(':sector', child_nav.name) if url.include?(':sector')
			return url.gsub(':industry', child_nav.name) if url.include?(':industry')
		end
	end
end
