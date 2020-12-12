require "application_system_test_case"

class CreateAndFillBunkersTest < ApplicationSystemTestCase


  test "create and fill bunker" do
    visit '/'
    assert_selector "form"

    fill_in "Email", with: users(:admin_user).email
    fill_in "Password", with: 'admin'
    click_on "Log in"

    assert_selector "a", text: "Items"
    assert_selector "a", text: "Users"
    assert_selector "a", text: "Bunkers"
    assert_selector "a", text: "New Bunker"

    click_on "New Bunker"
    fill_in "Name", with: "System Test Bunker"
    fill_in "Address", with: "localhost"
    fill_in "Capacity", with: 2
    click_on "Save"

    assert_selector "a", text: "New Inventory Item"
    assert_selector "a", text: "Assign new user"

    click_on "New Inventory Item"
    fill_in "Food type", with: "Canned beans"
    fill_in "Quantity", with: 100
    fill_in "Nutrition per unit", with: 2000

    click_on "Save"
    click_on "System Test Bunker"
    assert_selector "td", text: "Canned beans"

    click_on "Assign new user"
    select users(:normal_user).name, from: "User"
    click_on "Assign"
    assert_selector "td", text: users(:normal_user).name

    user2 = User.find users(:fill_user_0).id
    visit user_path(user2)
    click_on "Assign to bunker"
    select "System Test Bunker", from: "Bunker"
    click_on "Assign"




  end


end
