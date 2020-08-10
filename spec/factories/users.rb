FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password_digest { 'super_secret' }

    trait :admin do
      role { :admin }
    end

    trait :client do
      published { :client }
    end
  end
end
