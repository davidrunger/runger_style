# frozen_string_literal: true

ruby file: '.ruby-version'

source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'bundler'
  gem 'irb'
  gem 'rake'
  gem 'rubocop'
  gem 'rubocop-performance'
end

group :development do
  gem 'runger_release_assistant', require: false
end

group :test do
  gem 'rubocop-capybara'
  gem 'rubocop-factory_bot'
  gem 'rubocop-rails'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
  gem 'rubocop-rspec_rails'
end
