# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"

User.create(
  name: "Tiago Matos", 
  email: "tiagofarma2010@gmail.com", 
  phone: "980044001", 
  birthdate: "01/05/1980", 
  role: 1, #0 Nâo cadastrado, 1-Admin, 2-Owner, 3-Client e 4-Deliveryman
  cpf: "08716131746",
  address: "Barão do Amazonas, 02",
  funds: 0,
  is_valid: true,
  password: "123456",
  password_confirmation: "123456"
  )

#Preenchimento dos usuários
20.times.each do    
  User.create(
    name: Faker::Name.name, 
    email: Faker::Internet.email, 
    phone: Faker::PhoneNumber.phone_number, 
    birthdate: Faker::Date.between(from: '1980-01-01', to: '2002-12-31'), 
    role: rand(2..4), #0 Nâo cadastrado, 1-Admin, 2-Owner, 3-Client e 4-Deliveryman
    cpf: Faker::IDNumber.brazilian_id,
    address: Faker::Address.full_address,
    funds: rand(0..100),
    is_valid: rand(0..1)==1 ? true : false,
    password: "123456",
    password_confirmation: "123456"
    )
  if User.last.role == 4 && User.last.is_valid == true
    user = User.last
    user.cnh = Faker::IDNumber.brazilian_id
    user.vehicle = Faker::Vehicle.make_and_model
    user.save
  end
end

#Preenchimento dos restaurantes
User.where(role: 2).each do |user|
  Restaurant.create(
    name: Faker::Restaurant.name ,
    foodType: Faker::Restaurant.type,
    owner_id: user.id,
    openingHour: rand(8..12).to_s + "-" + rand(18..23).to_s,
    address: Faker::Address.full_address,
    cnpj: Faker::Company.brazilian_company_number
  )
end

#=begin

100.times.each do    
  Dish.create(
    name: Faker::Food.dish,
    description: Faker::Food.description,
    value: (rand(1..100)/rand(1..10))+1,
    portionSize: rand(1..3),
    quantity: rand(0..10),
    restaurant_id: rand(1..Restaurant.count)
    )
end

#=begin
50.times.each do
  clients =  User.where(role: 3)
  client = clients[rand(0...clients.count)]
  deliverymen = User.where(role: 4)
  deliveryman = deliverymen[rand(0...deliverymen.count)]
  is_delivered = rand(0..1)==1 ? true : false
  restaurant = Restaurant.find(rand(1..Restaurant.count))
  #puts restaurant
  Order.create(
    is_confirmed: rand(0..1) == 1 ? true : is_delivered,
    is_done: rand(0..1) == 1 ? true : is_delivered,
    grade: is_delivered ? rand(1..5) : nil,
    deliveryman_id: is_delivered ? deliveryman.id : nil,
    client_id: client.id,
    total_value: rand(10..50),
    restaurant_id: restaurant.id
  )

   #== 1 ? User.where(role: 4).offset(rand(0..(User.where(role: 4).count-1)).first) : nil
  #puts restaurant.name
  totalDishes = rand(0..3)
  #byebug
  totalDishes.times.each do 
    dishes = Dish.where(restaurant_id: restaurant.id)
    next if dishes.count==0
    indice = rand(0...dishes.count)
    dish = dishes[indice]
    puts dish
  #byebug
    OrderDish.create(
      order_id: Order.last.id,
      dish_id: dish.id,
      quantity: rand(1..2)
    )    
  end
end 
#=end

# User.offset(0).first

# User.where(role: 2)taurant