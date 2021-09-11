FactoryBot.define do
  sequence :full_name do |n|
    "full_name_#{n}"
  end
  sequence :name do |n|
    "name_#{n}"
  end
  sequence :address do |n|
    "address_#{n}"
  end

  factory :volunteer, class: "User" do
    full_name { generate(:full_name) }
    email { Faker::Internet.email }
    phone { Faker::Number.number(digits: 10) }
    password { "password123" }
    role { User.roles[:volunteer] }
  end

  factory :user, class: "User" do
    full_name { generate(:full_name) }
    email { Faker::Internet.email }
    phone { Faker::Number.number(digits: 10) }
    verified { true }
    password { "password123" }
    role { User.roles[:asha] }
  end
end
