require 'test_helper'

class BunkersControllerTest < ActionDispatch::IntegrationTest
  include SignInHelper

  setup do
    @bunker = bunkers(:alpha)
  end

  test "should get index" do
    sign_in_as_normal_user
    get bunkers_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as_admin
    get new_bunker_url
    assert_response :success
  end

  test "should create bunker" do
    sign_in_as_admin
    assert_difference('Bunker.count') do
      post bunkers_url, params: { bunker: { address: @bunker.address, capacity: @bunker.capacity, name: @bunker.name } }
    end

    assert_redirected_to bunker_url(Bunker.last)
  end

  test "should show bunker" do
    sign_in_as_normal_user
    get bunker_url(@bunker)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as_admin
    get edit_bunker_url(@bunker)
    assert_response :success
  end

  test "should update bunker" do
    sign_in_as_admin
    patch bunker_url(@bunker), params: { bunker: { address: @bunker.address, capacity: @bunker.capacity, name: @bunker.name } }
    assert_redirected_to bunker_url(@bunker)
  end

  test "should destroy bunker" do
    sign_in_as_admin
    assert_difference('Bunker.count', -1) do
      delete bunker_url(@bunker)
    end

    assert_redirected_to bunkers_url
  end
end
