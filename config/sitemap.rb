# Set the host name for URL creation

  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
SitemapGenerator::Sitemap.default_host = 'http://www.alphapitch.com'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new
# SitemapGenerator::Sitemap.sitemaps_host = "http://alphapitch.s3.amazonaws.com/"
SitemapGenerator::Sitemap.public_path = 'public/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'


SitemapGenerator::Sitemap.create do
  add root_path, :changefreq => 'daily'
  
  Company.find_each do |company|
    if(company.pitches.present? || company.questions.present?)
      add company_path(company), lastmod: company.updated_at
    end
  end
  Pitch.find_each do |pitch|
    add pitch_path(pitch), lastmod: pitch.updated_at
  end
  add '/contact', :changefreq =>  'monthly'
  add '/about', :changefreq =>  'monthly'
  add '/terms', :changefreq =>  'monthly'
end
SitemapGenerator::Sitemap.ping_search_engines

