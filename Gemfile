# require 'rubygems'
# require 'mongo'

source 'http://rubygems.org'
gem 'heroku'

gem 'rails', '3.1.2'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# gem 'nokogiri'
gem 'crack'
gem 'decent_exposure'
gem 'mongo'
gem 'mongo_mapper'
gem 'bson_ext'
gem 'haml'

group :production do
  gem 'therubyracer-heroku'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5.rc.2'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test, :development do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
  gem "capybara"
  gem "database_cleaner"
  gem "rspec"
  gem "rspec-rails"
  gem "cucumber"
  gem "capybara"
  gem "cucumber-rails"
  gem "launchy" # then show me the page 
  gem "guard"
  gem "guard-rspec"
  gem 'rb-fsevent'
  gem 'growl_notify'
end
