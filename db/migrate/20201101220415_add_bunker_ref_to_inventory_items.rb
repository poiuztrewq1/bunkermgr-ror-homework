class AddBunkerRefToInventoryItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :inventory_items, :bunker, null: false, foreign_key: true
  end
end
