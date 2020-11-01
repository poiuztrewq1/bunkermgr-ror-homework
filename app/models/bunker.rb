class Bunker < ApplicationRecord
  validates :capacity, numericality: true
  has_many :inventory_items, dependent: :destroy
  has_and_belongs_to_many :users
end
