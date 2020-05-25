source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'rails', '~> 6.0.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'activeadmin'
gem 'telegram-bot'
gem 'sidekiq'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'bullet'
  gem 'rubocop', require: false
  gem 'rails_best_practices'
  gem 'traceroute'
  gem 'reek'
  gem 'brakeman', require: false
  gem 'rubycritic', require: false
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'byebug'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'faker'
  gem 'fasterer'
  gem 'bundler-audit'
end

group :test do
  gem 'simplecov',      require: false
  gem 'simplecov-html', require: false
  gem 'simplecov-json', require: false
  gem 'simplecov-rcov', require: false
end
