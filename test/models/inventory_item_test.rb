require 'test_helper'

class InventoryItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should save item" do
    b = Bunker.find bunkers(:alpha).id
    i = InventoryItem.new(food_type:          "Food name",
                          exp_date:           DateTime.now,
                          quantity:           10,
                          nutrition_per_unit: 2500,
                          bunker: b)
    assert i.save, "Couldn't save a valid item"
  end

  test "should not save without food type" do
    i = InventoryItem.new
    i.exp_date = DateTime.now
    i.quantity = 10
    i.nutrition_per_unit = 2500
    i. bunker = Bunker.find(bunkers(:alpha).id)
    assert_not i.save, "Could save without name"
  end

  test  "should not save with invalid quantity" do
    i = InventoryItem.new
    i.food_type = "food"
    i.exp_date = DateTime.now
    i.nutrition_per_unit = 2500
    i. bunker = Bunker.find(bunkers(:alpha).id)
    assert_not i.save, "Could save without quantity"

    i.quantity = 10.3
    assert_not i.save, "Could save with fraction quantity"

    i.quantity = -5
    assert_not i.save, "Could save with negative quantity"
  end

  test  "should not save with invalid nutrition" do
    i = InventoryItem.new
    i.food_type = "food"
    i.exp_date = DateTime.now
    i.quantity = 10
    i. bunker = Bunker.find(bunkers(:alpha).id)
    assert_not i.save, "Could save without nutrition value"

    i.nutrition_per_unit = 10.3
    assert_not i.save, "Could save with nutrition value"

    i.nutrition_per_unit = -5
    assert_not i.save, "Could save with negative nutrition value"
  end

  test "should return valid nutrition sum" do
    data = [[10,2012],[0,3560,],[32,0]]
    data.each do |d|
      i = InventoryItem.new
      i.quantity = d[0]
      i.nutrition_per_unit = d[1]
      assert_equal d[0]*d[1], i.sum_calories
    end
  end

  test "should return valid days til expiration" do
    data = [-5,30,45,60,120]
    data.each do |d|
      i = InventoryItem.new
      i.exp_date = DateTime.now.next_day(d)
      assert_equal d, i.days_til_exp
    end
  end

  test "should return valid class" do
    data = [[-10,"text-danger"],[0,"text-danger"],[25,"text-warning"],[30,"text-warning"],[45,"text-success"]]
    data.each do |d|
      i = InventoryItem.new
      i.exp_date = DateTime.now.next_day(d[0])
      assert_equal d[1], i.expiration_class
    end
  end

end
