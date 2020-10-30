class CreateInventoryItems < ActiveRecord::Migration[6.0]
  def change
    create_table :inventory_items do |t|
      t.string :food_type
      t.date :exp_date
      t.integer :quantity
      t.integer :nutrition_per_unit

      t.timestamps
    end
  end
end
