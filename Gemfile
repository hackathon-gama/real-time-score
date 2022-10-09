# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.4', '>= 1.4.3'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS),
# making cross-origin AJAX possible
# gem "rack-cors"

gem 'newrelic_rpm'
gem 'newrelic-infinite_tracing'

group :development, :test do
  # https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'byebug'

  gem 'dotenv-rails' # Loads .env file

  # Code linting gems
  gem 'rubocop', '~> 1.26', '>= 1.26.1'
  gem 'rubocop-github'
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', '~> 2.13', '>= 2.13.2', require: false

  # Testing
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker'
  gem 'rspec-rails', '~> 5.1', '>= 5.1.1'
end

group :development do
  # static analysis tools which checks Ruby on Rails
  # applications for security vulnerabilities
  gem 'brakeman', '~> 5.3', '>= 5.3.1'
  gem 'bullet', '~> 7.0', '>= 7.0.3'
  gem 'guard'
  gem 'guard-rspec', '~> 4.7'

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'shoulda-matchers'
end
