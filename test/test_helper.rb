ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

module  SignInHelper
  def sign_in_as_admin
    post url_for(controller: 'sessions', action: 'create'), params: {
      email: users(:admin_user).email,
      password: 'admin'
    }
  end

  def sign_in_as_normal_user
    post url_for(controller: 'sessions', action: 'create'), params: {
      email: users(:normal_user).email,
      password: '123456'
    }
  end
end