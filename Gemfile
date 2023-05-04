# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'bundler'
  gem 'rake'
  gem 'rubocop'
  gem 'rubocop-performance'
end

group :development do
  gem 'release_assistant', require: false, github: 'davidrunger/release_assistant'
end

group :test do
  gem 'rubocop-capybara'
  gem 'rubocop-rails'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
end
