source 'https://rubygems.org'
ruby File.read(".ruby_version").strip

# Requirement of GoogleTrend
gem 'google_search_results'

# Configuration and Utilities
gem 'figaro', '~> 1.2'

# Web Application
gem 'puma', '~> 6'
gem 'roda', '~> 3'
gem 'slim', '~> 4'

gem 'bootstrap', '~> 5.2.2'

# Debugging
gem 'pry'

# Validation
gem 'dry-struct', '~> 1'
gem 'dry-types', '~> 1'

# Networking
gem 'http', '~> 5'

gem 'jruby-openssl', platforms: :jruby
gem 'rake'
gem 'yard'

# Database
gem 'hirb', '~> 0'
gem 'hirb-unicode', '~> 0'
gem 'sequel', '~> 5.49'

group :development, :test do
  gem 'sqlite3', '~> 1.4'
end

# Debugging
gem 'pry'

group :production do
  gem 'pg'
end

# Testing
group :test do
  gem 'minitest', '~> 5'
  gem 'minitest-rg', '~> 5'
  gem 'coveralls', '>= 0.8.23'
  gem 'rspec', '>= 2.14'
  gem 'simplecov', '>= 0.16'
  gem 'timecop'
  gem 'webmock', '~> 3'
  gem 'vcr', '~> 6'
  gem 'yardstick'
end

group :development do
    gem 'rerun', '~> 0'
end

# Code Quality
group :development do
  gem 'flog'
  gem 'reek'
  gem 'rubocop'
end

