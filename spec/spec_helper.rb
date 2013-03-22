# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'factory_girl'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
  :provider => 'facebook',
  :uid => '123456',
  :email => 'spree@example.com',
  :name => 'mock_auth_test',
  :host => 'localhost:3000',
  :extra => {:raw_info => 
              {
               :uuid     => "1234",
               :username => 'mock_auth_test_username',
               :facebook => {
                             :email => "foobar@example.com",
                             :gender => "Male",
                             :first_name => "foo",
                             :last_name => "bar",
                             :nickname => "foo bar",
                             :image => 'http://graph.facebook.com/659307629/picture?type=square'
                             }
              }
    }
  
  # etc.
})

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  config.include Rails.application.routes.url_helpers

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = true

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
  
  config.include(CompaniesMacros)
  config.include(JobsMacros)
  config.include(UsersMacros)
  config.include(LoginMacros)
  config.before(:each) do 
    reset_companies
    reset_users
    reset_jobs
  end
end
