class Bunker < ApplicationRecord
  has_many :inventory_items, dependent: :destroy
  has_and_belongs_to_many :users

  validates :capacity, numericality: { only_integer: true }
  validates :name, presence: true
  validates :address, presence: true
  validate :cannot_have_more_users_than_capacity

  def sum_stocked_calories
    inventory_items.map(&:sum_calories).sum
  end

  def estimated_stocks
    users.empty? ? Float::INFINITY : sum_stocked_calories / (2000 * users.length)

  end

  def next_expiring_item
    inventory_items.min_by(&:days_til_exp)
  end

  def full?
    users.length >= capacity
  end

end
