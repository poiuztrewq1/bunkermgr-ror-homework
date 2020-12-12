require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase

  test "log in and log out" do
    visit '/'
    assert_selector 'form'

    # invalid login
    fill_in "Email", with: users(:normal_user).email
    fill_in "Password", with: "not the passsowrd"
    click_on "Log in"

    assert_selector 'div.alert'

    # valid login
    fill_in "Email", with: users(:normal_user).email
    fill_in "Password", with: "123456"

    click_on "Log in"

    assert_selector "table"
    assert_selector "a", text: "Log Out"

    click_on "Log Out"

    assert_selector "div", text: "Log In"

  end


  test "register new user" do
    visit '/'
    assert_selector "a", text: "Sign Up"
    click_on "Sign Up"

    # invalid registration no.1
    fill_in "Name", with: "System Test User"
    fill_in "Email", with: users(:normal_user).email
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Register"
    assert_selector 'div.alert'

    # invalid registration no.2
    fill_in "Name", with: "System Test User"
    fill_in "Email", with: "notregistered@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "not the same"

    click_on "Register"
    assert_selector 'div.alert'

    #successful registration
    fill_in "Name", with: "System Test User"
    fill_in "Email", with: "notregistered@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Register"
    assert_selector "a", text: "Log Out"


  end


end
