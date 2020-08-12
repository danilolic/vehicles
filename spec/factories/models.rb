FactoryBot.define do
  factory :model do
    name { Faker::Vehicle.model }
    brand
  end
end
