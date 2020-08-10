FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'super_secret' }
    role { :client }

    trait :admin do
      role { :admin }
    end
  end
end
