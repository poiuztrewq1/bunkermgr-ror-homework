require 'test_helper'

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get assign_user" do
    get assignments_assign_user_url
    assert_response :success
  end

  test "should get assign_bunker" do
    get assignments_assign_bunker_url
    assert_response :success
  end

  test "should get assign" do
    get assignments_assign_url
    assert_response :success
  end

  test "should get destroy" do
    get assignments_destroy_url
    assert_response :success
  end

end
