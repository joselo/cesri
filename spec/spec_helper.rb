ENV["RAILS_ENV"] ||= "test"

require 'bundler/setup'
require 'rspec'
require 'cesri'
require 'savon'
require 'savon/mock/spec_helper'

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

def restore_default_config
  Cesri.configuration = nil
  Cesri.configure {}
end

def load_default_config
  Cesri.configure do |config|
  end
end