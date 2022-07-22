# frozen_string_literal: true

require_relative '../server'
require 'setup/setup_test_database'
require 'rack/test'
require 'sidekiq/testing/inline'
require 'rspec-sidekiq'

ENV['RACK_ENV'] = 'test'
module RSpecMixin
  def app
    Server.new
  end
end

RSpec::Sidekiq.configure do |config|
  # Clears all job queues before each example
  config.clear_all_enqueued_jobs = true # default => true
  # Whether to use terminal colours when outputting messages
  config.enable_terminal_colours = true # default => true
  # Warn when jobs are not enqueued to Redis but to a job array
  config.warn_when_jobs_not_processed_by_sidekiq = true # default => true
end

RSpec.configure do |config|
  ENV['RACK_ENV'] = 'test'

  config.include Rack::Test::Methods
  config.include RSpecMixin

  config.before(:each) do
    setup_test_database!
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
