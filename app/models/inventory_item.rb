class InventoryItem < ApplicationRecord
  belongs_to :bunker

  validates :quantity, presence: true,  numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :food_type, presence: true
  validates :nutrition_per_unit, presence:true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  def sum_calories
    nutrition_per_unit * quantity
  end

  def days_til_exp
    exp_date.mjd - Time.new.to_date.mjd
  end

  def expiration_class
    days = days_til_exp
    if days <= 30 && days.positive?
      'text-warning'
    elsif days <= 0
      'text-danger'
    else
      'text-success'
    end
  end

end
