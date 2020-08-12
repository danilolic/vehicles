FactoryBot.define do
  factory :vehicle do
    value { "R$ #{Faker::Commerce.price(range: 5_000..10_000_000.0, as_string: true)}" }
    model
    year_model { Faker::Vehicle.year }
    fuel { Faker::Vehicle.fuel_type }
  end
end
