source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.8'

gem 'heroku'

group :test, :development do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
  gem 'thin'
end


group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'pry'
  gem 'debugger'
end
