require 'test_helper'

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  include SignInHelper

  test "should get assign_user" do
    sign_in_as_admin
    get url_for controller: 'assignments', action: 'assign_user', bunker_id: bunkers(:alpha)
    assert_response :success
  end

  test "should retrun full bunker error" do
    sign_in_as_admin
    get url_for controller: 'assignments', action: 'assign_user', bunker_id: bunkers(:beta)
    assert_redirected_to bunker_path bunkers(:beta).id
    assert_equal 'Bunker already full', flash[:alert]
  end

  test "should return no possible users error" do
    sign_in_as_admin
    get url_for controller: 'assignments', action: 'assign_user', bunker_id: bunkers(:delta)
    assert_redirected_to bunker_path bunkers(:delta).id
    assert_equal "All possible users are assigned to #{bunkers(:delta).name}", flash[:alert]
  end

  test "should get assign_bunker" do
    sign_in_as_admin
    get url_for controller: 'assignments', action: 'assign_bunker', user_id: users(:normal_user)
    assert_response :success
  end


  test "should assign user to bunker" do
    sign_in_as_admin
    alpha = Bunker.find bunkers(:alpha).id
    original = alpha.users.count
    post url_for(controller: 'assignments', action: 'assign'), params: { user_id: users(:fill_user_0).id, bunker_id: alpha.id }
    assert_redirected_to root_path
    assert_equal original+1, alpha.users.count
  end

  test "should delete assignment" do
    sign_in_as_admin
    alpha = Bunker.find bunkers(:alpha).id
    user = User.find users(:normal_user).id
    original_user_count = alpha.users.count
    original_bunker_count = user.bunkers.count

    delete url_for controller: 'assignments', action: 'destroy', user_id: user.id, bunker_id: alpha.id

    assert_redirected_to root_path
    assert_equal original_user_count-1, alpha.users.count
    assert_equal original_bunker_count-1, user.bunkers.count
  end

end
