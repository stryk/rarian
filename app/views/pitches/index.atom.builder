atom_feed :language => 'en-US' do |feed|
	feed.title "AlphaPitch - Articles"
	feed.updated @pitches.maximum(:updated_at)
	@pitches.each do |article|
		next unless article.published == true

		feed.entry article, published: article.published_at do |entry|
			entry.title article.title
			entry.summary truncate("#{sanitize (article.multimedia_content), tags: %w{}}", length: 140, separator: ' ')
			entry.content article.multimedia_content, type: 'html'
			entry.author do |author|
				author.name article.user.name
			end
			entry.category term: "symbol", label: "ticker", scheme: company_url(article.company)
			entry.category term: "author", label: article.user.name, scheme: user_url(article.user)
		end
	end

end