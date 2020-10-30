require "application_system_test_case"

class BunkersTest < ApplicationSystemTestCase
  setup do
    @bunker = bunkers(:one)
  end

  test "visiting the index" do
    visit bunkers_url
    assert_selector "h1", text: "Bunkers"
  end

  test "creating a Bunker" do
    visit bunkers_url
    click_on "New Bunker"

    fill_in "Address", with: @bunker.address
    fill_in "Capacity", with: @bunker.capacity
    fill_in "Name", with: @bunker.name
    click_on "Create Bunker"

    assert_text "Bunker was successfully created"
    click_on "Back"
  end

  test "updating a Bunker" do
    visit bunkers_url
    click_on "Edit", match: :first

    fill_in "Address", with: @bunker.address
    fill_in "Capacity", with: @bunker.capacity
    fill_in "Name", with: @bunker.name
    click_on "Update Bunker"

    assert_text "Bunker was successfully updated"
    click_on "Back"
  end

  test "destroying a Bunker" do
    visit bunkers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bunker was successfully destroyed"
  end
end
