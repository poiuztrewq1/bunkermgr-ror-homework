class Bunker < ApplicationRecord
  validates :capacity, numericality: true
  has_many :inventory_items, dependent: :destroy
  has_and_belongs_to_many :users


  def sum_stocked_calories
    inventory_items.map {|i| i.sum_calories}.sum
  end

  def estimated_stocks
    # estimation: 2000 kcal per person per day
    sum_stocked_calories / 2000
  end

  def next_expiring_item
    now = Time.new.to_date
    inventory_items.sort{ |a| a.exp_date.mjd - now.mjd }.first
  end

end
