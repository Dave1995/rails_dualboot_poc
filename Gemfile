source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

if ENV['RAILS_NEXT']
  gem 'rails', '5.0.7.2'
  gem 'rails-controller-testing'
  gem 'pg', '~> 0.15', :platforms => :mri
  gem 'activerecord-jdbcpostgresql-adapter', '~> 50', '>= 1.50.3', platforms: :jruby
else
  gem 'rails', '4.2.11'
  gem 'pg', '~> 0.15', :platforms => :mri
end
# Use postgresql as the database for Active Record
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug',  :platforms => :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

