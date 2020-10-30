require 'test_helper'

class BunkersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bunker = bunkers(:one)
  end

  test "should get index" do
    get bunkers_url
    assert_response :success
  end

  test "should get new" do
    get new_bunker_url
    assert_response :success
  end

  test "should create bunker" do
    assert_difference('Bunker.count') do
      post bunkers_url, params: { bunker: { address: @bunker.address, capacity: @bunker.capacity, name: @bunker.name } }
    end

    assert_redirected_to bunker_url(Bunker.last)
  end

  test "should show bunker" do
    get bunker_url(@bunker)
    assert_response :success
  end

  test "should get edit" do
    get edit_bunker_url(@bunker)
    assert_response :success
  end

  test "should update bunker" do
    patch bunker_url(@bunker), params: { bunker: { address: @bunker.address, capacity: @bunker.capacity, name: @bunker.name } }
    assert_redirected_to bunker_url(@bunker)
  end

  test "should destroy bunker" do
    assert_difference('Bunker.count', -1) do
      delete bunker_url(@bunker)
    end

    assert_redirected_to bunkers_url
  end
end
