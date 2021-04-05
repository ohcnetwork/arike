FactoryBot.define do
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
end
