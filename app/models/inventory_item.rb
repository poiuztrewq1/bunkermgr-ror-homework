class InventoryItem < ApplicationRecord
  validates :quantity, numericality: true
end
