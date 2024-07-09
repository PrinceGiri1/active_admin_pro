# spec/rails_helper.rb
require 'simplecov'
SimpleCov.start
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rails'
require 'factory_bot_rails'
require 'rails-controller-testing'
Rails::Controller::Testing.install

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |file| require file }

ActiveRecord::Migration.maintain_test_schema!

# spec/rails_helper.rb

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Warden::Test::Helpers
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

