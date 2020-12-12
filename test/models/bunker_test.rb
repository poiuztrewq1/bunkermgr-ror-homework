require 'test_helper'

class BunkerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should save bunker without error" do
    b          = Bunker.new
    b.name     = "Valid Bunker"
    b.address  = "Valid Address"
    b.capacity = 10
    assert b.save, "Could not save valid bunker"
  end

  test "should not save bunker without name" do
    b          = Bunker.new
    b.address  = "Address"
    b.capacity = 10
    assert_not b.save, "Could save bunker without name"
  end

  test "should not save bunker without address" do
    b          = Bunker.new
    b.name     = "Invalid Bunker"
    b.capacity = 10
    assert_not b.save, "Could save bunker without address"
  end

  test "should not save bunker with invalid capacity" do
    b          = Bunker.new
    b.name     = "Invalid Bunker"
    b.address  = "Address"
    b.capacity = 5.2
    assert_not b.save, "Could save bunker with fraction capacity"
    b.capacity = -2
    assert_not b.save, "Could save bunker with negative capacity"
  end

  test "should return valid fullness" do
    b = Bunker.new(name: "Test bunker", address: "Address", capacity: 1)
    assert_not b.full?, "Returns true when not full"
    u = User.find users(:normal_user).id
    b.users << u
    assert b.full?, "Returns false when full"
  end

  test "should return sum of calories" do
    b = Bunker.find bunkers(:alpha).id
    assert_equal b.inventory_items.map(&:sum_calories).sum, b.sum_stocked_calories ,"Calculation of stocked calories are wrong"
  end

  test "should return next expiring item" do
    a = Bunker.find bunkers(:alpha).id
    exp1 = InventoryItem.find inventory_items(:f1_expired).id
    assert_equal exp1, a.next_expiring_item, "Returned wrong item"

    b = Bunker.find bunkers(:beta).id
    exp2 = InventoryItem.find inventory_items(:f2_almost_expired).id
    assert_equal exp2, b.next_expiring_item, "Returned wrong item"

    c = Bunker.find bunkers(:gamma).id
    exp3 = InventoryItem.find inventory_items(:f3).id
    assert_equal exp3, c.next_expiring_item, "Returned wrong item"
  end

  test "should return correct estimated stocks" do
    empty = Bunker.new
    assert_equal Float::INFINITY, empty.estimated_stocks, "Empty bunker not returning infinity"

    test_data = [bunkers(:alpha).id,bunkers(:beta).id,bunkers(:gamma).id,bunkers(:delta).id]

    test_data.each do |bunker_id|
      bunker = Bunker.find bunker_id
      assert_equal bunker.sum_stocked_calories / (2000 * bunker.users.length), bunker.estimated_stocks, "Wrong way of calculating estimated stocks"
    end

  end


end
