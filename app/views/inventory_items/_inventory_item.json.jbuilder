json.extract! inventory_item, :id, :food_type, :exp_date, :quantity, :nutrition_per_unit, :created_at, :updated_at
json.url inventory_item_url(inventory_item, format: :json)
