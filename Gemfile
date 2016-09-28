source 'https://rubygems.org'

ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib
  end

  gem 'db-query-matchers'

  # Rubocop power
  gem 'rubocop'

  gem 'foreman'

  # debug requests on development
  gem 'meta_request'

  # This gem is for using ruby objects for test data instead of fixtures
  # Read more: https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
  gem 'factory_girl_rails'

  # Fake data
  gem 'ffaker'

  # Load env variables from .env file
  gem 'dotenv-rails'

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # 4-cores? 4-times the testing speed! See: https://github.com/grosser/parallel_tests
  gem 'parallel_tests'

  gem 'better_errors'
  gem 'binding_of_caller'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Hyper-concurent job worker
gem 'sidekiq' # sidekiq must be before Airbrake in Gemfile!
# Scheduler
gem 'sidekiq-scheduler', '~> 2.0'
# Sidekiq uniq job
gem 'sidekiq-unique-jobs'

gem 'sinatra', require: nil

# IRB nice printing
gem 'awesome_print'

# gem for meta tags
gem 'meta-tags'

# Rubygems API
gem 'gems'

# Github API
gem 'octokit'

# TimeDifference
gem 'time_difference'

# User authentication
gem 'devise'
gem 'omniauth'
gem 'omniauth-github'

# template engine
gem 'slim'

gem 'gravatarify', '~> 3.0.0'

# friendly urls
gem 'friendly_id', '~> 5.1.0'

# Error tracking
gem 'scout_apm'

# Newrelic
gem 'newrelic_rpm'

# Superadmin
gem 'rails_admin', '~> 1.0'

# bootstrap
gem 'less-rails', '~> 2.7.0'
gem 'twitter-bootstrap-rails'

# autoprefixer
gem 'autoprefixer-rails'

# markdown parser
gem 'redcarpet'

# sitemap
gem 'sitemap_generator'
gem 'fog-aws'

gem 'rack-mini-profiler', require: false
