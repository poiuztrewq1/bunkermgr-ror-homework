require 'test_helper'

class AssignUserToBunkerTest < ActionDispatch::IntegrationTest

  test "assign user" do
    test_bunker = Bunker.find bunkers(:alpha).id
    #register a new user
    get url_for controller: "users", action: 'new'
    assert_response :success
    assert_select 'form input',5

    post url_for(controller: 'users', action: 'create'), params: {
      user: {
        name: 'User Name',
        email: 'email.notindb@example.com',
        password: '123456',
        password_confirmation: '123456'
      }
    }

    assert_redirected_to user_url User.last
    follow_redirect!

    new_user = User.last
    assert_equal new_user.id, session[:user_id]
    assert_equal 0, new_user.bunkers.count

    # log out
    get url_for controller: 'sessions', action: 'destroy'
    assert_redirected_to login_path
    assert_nil session[:user_id]
    follow_redirect!

    #login as admin
    get url_for controller: "sessions", action: "new"
    assert_response :success
    assert_select 'form input',3

    post url_for(controller: 'sessions', action: 'create'), params: {
      email: users(:admin_user).email,
      password: 'admin'
    }
    assert_response :redirect
    assert_equal users(:admin_user).id , session[:user_id]
    assert_equal 'You have successfully logged in', flash[:notice]
    follow_redirect!
    assert_select "a[href=?]", bunker_path(test_bunker)

    # navigate to bunkers info page and assign the new user
    get url_for bunker_url(test_bunker)
    assert_response :success
    assert_select "a[href=?]", assign_user_path(test_bunker)

    get assign_user_path(test_bunker)
    assert_response :success
    assert_select "option[value=?]", new_user.id.to_s

    post assign_url, params:{bunker_id: test_bunker.id, user_id:new_user.id}
    assert_redirected_to bunker_path(test_bunker)
    assert_equal 'Assignment successful', flash[:notice]
    assert_equal 1, new_user.bunkers.count

    # log out
    get url_for controller: 'sessions', action: 'destroy'
    assert_redirected_to login_path
    assert_nil session[:user_id]
    follow_redirect!

    # login as the user
    post url_for(controller: 'sessions', action: 'create'), params: {
      email: new_user.email,
      password: '123456'
    }
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", bunker_path(test_bunker)

  end


end
