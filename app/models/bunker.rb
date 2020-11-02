# frozen_string_literal: true

class Bunker < ApplicationRecord
  validates :capacity, numericality: true
  has_many :inventory_items, dependent: :destroy
  has_and_belongs_to_many :users

  def sum_stocked_calories
    inventory_items.map(&:sum_calories).sum
  end

  def estimated_stocks
    # estimation: 2000 kcal per person per day
    sum_stocked_calories / 2000
  end

  def next_expiring_item
    inventory_items.min_by(&:days_til_exp)
  end
end
