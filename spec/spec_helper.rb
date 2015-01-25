ENV['RACK_ENV'] ||= 'test'

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'rspec'

# load the application
require File.expand_path('../../app', __FILE__)
require 'rack/test'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
  Sinatra::Application
end

# load in the support directory
Dir['support/**/*.rb'].each { |f| require File.expand_path f, __dir__ }

# bring up the migrations
ActiveRecord::Migrator.up 'db/migrate'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # specs should run randomly.
  config.order = :random
  Kernel.srand config.seed
end
