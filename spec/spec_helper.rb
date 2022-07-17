require_relative '../server'
require 'setup/setup_test_database'
require 'rack/test'

ENV['RACK_ENV'] = 'test'
module RSpecMixin
  include Rack::Test::Methods

  def app
    Server.new
  end
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
