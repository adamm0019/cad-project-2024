source "https://rubygems.org"

ruby "3.3.5"
gem "rails", "~> 7.1.2"  # Using stable version
gem "pg"
gem "puma"
gem "devise"           # Authentication
gem "pundit"          # Authorization
gem "sidekiq"         # Background job processing
gem "paper_trail"     # Track changes to records
gem "kaminari"        # Pagination
gem "ransack"         # Search functionality
gem "aws-sdk-s3"      # File storage
gem "rspec-rails"     # Testing framework

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem "letter_opener"  # Preview emails in the browser
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "shoulda-matchers"  # Added for model validation testing
  gem "database_cleaner-active_record"  # Added for cleaning test database
end

# Asset handling
gem "sprockets-rails"
gem "importmap-rails" 
gem "turbo-rails"
gem "stimulus-rails"

# Charts and analytics
gem 'chartkick'
gem 'groupdate'
