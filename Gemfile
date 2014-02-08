source 'https://rubygems.org'

ruby '2.0.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 2.1.1'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~>3.0.4'

gem 'acts_as_commentable'

gem "acts_as_follower"

gem "rmagick"

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks', '~>1.3.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'puma'

gem 'bootstrap-sass'

gem "ckeditor"

gem "ckeditor_rails"

gem "carrierwave"

gem "mini_magick"

gem 'protected_attributes'

gem 'make_voteable'

gem 'client_side_validations', :git =>  'git@github.com:bcardarella/client_side_validations.git', :branch => '4-0-beta'

gem "aws-ses"

gem "configatron"

gem "carrierwave"

gem "nokogiri"

gem 'spinjs-rails'

gem 'will_paginate', '~> 3.0'

gem 'sidekiq'
gem 'aws-sdk'

gem 'cancan'
gem "devise", "~> 3.0.0"
gem 'devise-async'

gem 'jquery-datatables-rails', git: 'git://github.com/rweng/jquery-datatables-rails.git'
gem 'jquery-ui-rails'
# gem 'friendly_id', :git => 'git@github.com:FriendlyId/friendly_id.git'
gem 'friendly_id', "~> 5.0.1"

gem 'sinatra', '>= 1.3.0', :require => nil

# Thinking-sphinx doc says require mysql2 even if you want to use postgres
gem 'mysql2', '0.3.12b4'
gem 'thinking-sphinx', '~> 3.1.0'
gem 'ts-sidekiq-delta', '~> 0.2.0'
group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
	# Use postgres as the database for Active Record
	gem 'pg'
	gem 'debugger'
  gem 'capistrano'
  gem 'rack-mini-profiler'
end

group :production do
	gem 'pg'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem "factory_girl_rails", "~> 4.0"
end

group :test do
  #gem 'capybara'
  #gem 'selenium-webdriver'
  #gem 'rest-client'
  #gem 'database_cleaner'
  #
  #gem 'cucumber-rails'
  gem 'database_cleaner'
end
# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
