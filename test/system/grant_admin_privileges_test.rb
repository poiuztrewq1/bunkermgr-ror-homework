require "application_system_test_case"

class GrantAdminPrivilegesTest < ApplicationSystemTestCase

  test "grant admin privilege to user" do
    normal_user = User.find users(:normal_user).id

    visit '/'
    assert_selector "form"

    fill_in "Email", with: users(:admin_user).email
    fill_in "Password", with: 'admin'
    click_on "Log in"
    assert_selector "a", text: "Items"
    assert_selector "a", text: "Users"
    assert_selector "a", text: "Bunkers"

    click_on "Users"
    assert_selector "td", text: normal_user.name

    visit user_path(normal_user)
    assert_selector "a", text: "Edit"
    assert_selector "p", text: "Role: User"

    click_on "Edit"
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    check "Admin"

    click_on "Save"
    assert_selector "p", text: "Role: Admin"


  end



end
