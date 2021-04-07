factory :family_details, class: "FamilyDetail" do
  full_name { generate(:full_name) }
  phone { Faker::Number.number(digits: 10) }
  relation { "Brother" }
  address { generate(:address) }
end
