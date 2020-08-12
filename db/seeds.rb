# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: 'admin', email: 'admin@email.com', password: '123456')

10.times do
  Brand.create(name: "#{Faker::Vehicle.make} - #{Faker::Vehicle.vin}")
end

10.times do
  Model.create(name: Faker::Vehicle.model, brand: Brand.order('RANDOM()').first)
end

50.times do
  model = Model.order('RANDOM()').first
  brand = model.brand

  Vehicle.create(
    value: "R$ #{Faker::Commerce.price(range: 5_000..10_000_000.0, as_string: true)}",
    year_model: Faker::Vehicle.year,
    fuel: Faker::Vehicle.fuel_type,
    model: model,
    brand: brand
  )
end
