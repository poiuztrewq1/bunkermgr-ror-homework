class Bunker < ApplicationRecord
  validates :capacity, numericality: true
end
