require 'test_helper'

class InventoryItemsControllerTest < ActionDispatch::IntegrationTest
  include SignInHelper

  setup do
    @inventory_item = inventory_items(:f1)
  end

  test "should get index" do
    sign_in_as_admin
    get inventory_items_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as_admin
    get url_for(controller: 'inventory_items', action: 'new'), params: {bunker_id: bunkers(:alpha).id}
    assert_response :success
  end

  test "should create inventory_item" do
    sign_in_as_admin
    assert_difference('InventoryItem.count') do
      post inventory_items_url, params: { inventory_item: { exp_date: @inventory_item.exp_date, food_type: @inventory_item.food_type, nutrition_per_unit: @inventory_item.nutrition_per_unit, quantity: @inventory_item.quantity, bunker_id: bunkers(:alpha).id } }
    end

    assert_redirected_to inventory_item_url(InventoryItem.last)
  end

  test "should show inventory_item" do
    sign_in_as_admin
    get inventory_item_url(@inventory_item)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as_admin
    get edit_inventory_item_url(@inventory_item)
    assert_response :success
  end

  test "should update inventory_item" do
    sign_in_as_admin
    patch inventory_item_url(@inventory_item), params: { inventory_item: { exp_date: @inventory_item.exp_date, food_type: @inventory_item.food_type, nutrition_per_unit: @inventory_item.nutrition_per_unit, quantity: @inventory_item.quantity } }
    assert_redirected_to inventory_item_url(@inventory_item)
  end

  test "should destroy inventory_item" do
    sign_in_as_admin
    assert_difference('InventoryItem.count', -1) do
      delete inventory_item_url(@inventory_item)
    end

    assert_redirected_to inventory_items_url
  end
end
