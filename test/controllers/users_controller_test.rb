require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "Register new user" do
    get url_for controller: 'users', action: 'new'
    assert_response :success
    assert_select 'form'
    assert_nil session[:user_id]

    post url_for(controller: 'users', action: 'create'), params: {
      user: {
        name: 'User Name',
        email: 'email.notindb@example.com',
        password: '123456',
        password_confirmation: '123456'
      }
    }

    assert_redirected_to user_url User.last
    assert_equal User.last.id, session[:user_id]

  end


end
