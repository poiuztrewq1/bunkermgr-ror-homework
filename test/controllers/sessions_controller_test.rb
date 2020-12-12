require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "login and logout" do
    get url_for controller: 'sessions', action: 'new'
    assert_response :success
    assert_select 'form'
    assert_nil session[:user_id]

    post url_for(controller: 'sessions', action: 'create'), params: {
      email: users(:normal_user).email,
      password: '123456'
    }
    assert_response :redirect
    assert_equal users(:normal_user).id , session[:user_id]
    assert_equal 'You have successfully logged in', flash[:notice]

    assert_redirected_to root_url

    get url_for controller: 'sessions', action: 'new'
    assert_response :redirect
    assert_equal users(:normal_user).id , session[:user_id]

    get url_for controller: 'sessions', action: 'destroy'
    assert_redirected_to login_path
    assert_nil session[:user_id]

    follow_redirect!
    assert_select 'form'

  end

  test "invalid login" do
    get url_for controller: 'sessions', action: 'new'
    assert_response :success
    assert_select 'form'
    assert_nil session[:user_id]

    post url_for(controller: 'sessions', action: 'create'), params: {
      email: users(:normal_user).email,
      password: 'not the pass'
    }
    assert_response :success
    assert_nil session[:user_id]
    assert_equal 'Your login credentials are invalid', flash[:alert]
  end


end
