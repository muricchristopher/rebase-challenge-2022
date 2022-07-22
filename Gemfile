# frozen_string_literal: true

source 'https://rubygems.org'

gem 'pg'
gem 'puma'
gem 'rack'
gem 'rake'
gem 'redis'
gem 'rubocop', require: false
gem 'sidekiq'
gem 'sinatra'
gem 'tilt-jbuilder', '>= 0.4.0', require: 'sinatra/jbuilder'

group :test do
  gem 'rspec-sidekiq'
end

group :test, :development do
  gem 'rack-test'
  gem 'rspec'
end
