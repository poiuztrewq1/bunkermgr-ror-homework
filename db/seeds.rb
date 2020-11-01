# frozen_string_literal: true

num_users           = 15
num_bunkers         = 5
min_item_per_bunker = 0
max_item_per_bunker = 15


#create a super-user, pass: 'admin'
User.create(name: 'Admin János', email: 'admin@admin.com', password: 'admin', admin: true)

num_bunkers.times do |_t|
  bunker   = Bunker.create(name:     Faker::Ancient.god,
                           address:  Faker::Address.street_address,
                           capacity: Faker::Number.between(from: 5, to: 100))
  num_item = Faker::Number.between(from: min_item_per_bunker, to: max_item_per_bunker)
  num_item.times do |_i|
    InventoryItem.create(food_type:          Faker::Food.dish,
                         exp_date:           Faker::Date.forward(days: 365),
                         quantity:           Faker::Number.between(from: 10, to: 100),
                         nutrition_per_unit: Faker::Number.between(from: 1000, to: 3000),
                         bunker:             bunker)
  end
  puts "Created bunker #{bunker.name} with #{num_item} inventory items"
end

num_users.times do |_t|
  user = User.create(name:     Faker::Name.name,
                     email:    Faker::Internet.safe_email,
                     password: Faker::Internet.password(min_length: 8, max_length: 10,))
  user.bunkers << Bunker.all.sample
  puts "creating user: #{user.name} with password: #{user.password}"
end