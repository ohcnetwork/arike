FactoryBot.define do
  sequence :first_name do |n|
    "first_name_#{n}"
  end
  sequence :full_name do |n|
    "full_name_#{n}"
  end

  factory :volunteer, class: "User" do
    first_name { generate(:first_name) }
    full_name  { generate(:full_name) }
    password { "password123" }
    role { "volunteer" }
  end
end
