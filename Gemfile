source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '3.2.12'

gem 'bootstrap-sass', '~> 2.0'
gem 'devise',         '~> 2'
gem 'haml-rails'
gem 'hirb'
gem 'jquery-rails'
gem 'pg'
gem 'pry'
gem 'pry-doc'
gem 'pry-rails'
gem 'rails_admin'
gem 'redcarpet'
gem 'sass-rails',     '~> 3.2.3'

group :assets do
  gem 'coffee-rails',    '~> 3.2.1'
  gem 'jquery-ui-rails'
  gem 'uglifier',        '>= 1.0.3'
end

group :production do
  gem 'newrelic_rpm'
  gem 'unicorn'
end

group :development do
  gem 'better_errors'
  gem 'foreman'
  gem 'mailcatcher'
  gem 'pry-debugger'
  gem 'yard'

  # guard
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'rb-fsevent'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'nokogiri', '~> 1.5.9'
  gem 'poltergeist'
  gem 'simplecov',          require: false
  gem 'spork'
  gem 'syntax'
  gem 'timecop'
  gem 'validation_matcher'
end
