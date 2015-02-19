require 'bundler/setup'
Bundler.setup

require 'fatboy'
require_relative './mocks/model.rb'
require 'timecop'
require 'mock_redis'

RSpec.configure do |config|
  # Don't need to actually do anything
end

