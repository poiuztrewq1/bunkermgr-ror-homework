# frozen_string_literal: true

class Bunker < ApplicationRecord
  validates :capacity, numericality: true
  has_many :inventory_items, dependent: :destroy
  has_and_belongs_to_many :users

  def sum_stocked_calories
    inventory_items.map(&:sum_calories).sum
  end

  def estimated_stocks
    users.empty? ? Float::INFINITY : sum_stocked_calories / (2000 * users.length)

  end

  def next_expiring_item
    inventory_items.min_by(&:days_til_exp)
  end
end
