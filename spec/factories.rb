FactoryBot.define do
  sequence :first_name do |n|
    "first_name_#{n}"
  end
  sequence :full_name do |n|
    "full_name_#{n}"
  end
  sequence :name do |n|
    "name_#{n}"
  end

  factory :volunteer, class: "User" do
    first_name { generate(:first_name) }
    full_name { generate(:full_name) }
    email { Faker::Internet.email }
    phone { Faker::Number.number(digits: 10) }
    password { "password123" }
    role { User.roles[:volunteer] }
  end

  factory :user, class: "User" do
    first_name { generate(:first_name) }
    full_name { generate(:full_name) }
    email { Faker::Internet.email }
    phone { Faker::Number.number(digits: 10) }
    verified { true }
    password { "password123" }
    role { User.roles[:asha] }
  end

  factory :lsg_body, class: "LsgBody" do
    name { generate(:name) }
    kind { "Panchayat" }
    code { "101" }
    district { "district" }
  end

  factory :ward, class: "Ward" do
    name { generate(:name) }
    number { Faker::Number.number(digits: 2) }
    lsg_body_id { LsgBody.last.id }
  end

  factory :facility, class: "Facility" do
    kind { "PHC" }
    name { Faker::Name.first_name }
    state { "Kerala" }
    district { "Ernakulum" }
    lsg_body_id { LsgBody.last.id }
    ward_id { Ward.last.id }
    address { "Test Address Body" }
    pincode { Faker::Number.number(digits: 7) }
    phone { Faker::Number.number(digits: 10) }
  end
end
