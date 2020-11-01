class InventoryItem < ApplicationRecord
  belongs_to :bunker
  validates :quantity, numericality: true
end
