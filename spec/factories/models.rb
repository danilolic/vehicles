FactoryBot.define do
  factory :model do
    sequence(:name) { |n| "#{Faker::Vehicle.model} - #{n}" }
    brand
  end
end
