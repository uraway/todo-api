source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.rc2', '< 5.1'
gem 'mysql2'
# Use Puma as the app server
gem 'puma', '~> 3.0'
gem 'active_model_serializers'
gem 'devise'
gem 'listen'
gem 'rack-cors', require: 'rack/cors'
gem 'chronic'

group :development, :test do
  gem 'faker'
  gem 'byebug'
  gem 'spring'
  gem 'annotate'
  # rspec gems ~~
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'json_spec'
  gem 'parallel_tests'
  gem 'fuubar'
  gem 'shoulda-matchers'
  gem 'autodoc', group: :test
  # ~~ rspec gems
end

group :development do
  gem 'web-console', '~> 2.0'
end

group :production do
  gem 'rails_12factor', '0.0.2'
end
