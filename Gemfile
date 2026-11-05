# frozen_string_literal: true

source 'https://rubygems.org'

# Single home for the Ruby version is `.ruby-version` (R7 fix) — referenced,
# never duplicated.
ruby file: '.ruby-version'

gem 'fast-mcp', '>= 1.0' # MCP server SDK (stdio) — exact pin recorded in Gemfile.lock
gem 'rake', '~> 13.2'
gem 'rspec', '~> 3.13'

group :static do
  # RuboCop >= 1.72 with `plugins:` syntax only — `require:` is forbidden (A17).
  gem 'rubocop', '>= 1.72', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-packaging', require: false # Bundler/ cops ship in rubocop core (no plugin needed)
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-thread_safety', require: false

  gem 'brakeman', require: false      # target-app gate; runs in the app's CI (A12)
  gem 'bundler-audit', require: false # needs a Gemfile.lock on disk (bootstrap PR #1)
  gem 'reek', require: false
  gem 'rubycritic', require: false
end
