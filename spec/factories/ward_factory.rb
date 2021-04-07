FactoryBot.define do
  factory :ward, class: "Ward" do
    name { generate(:name) }
    number { Faker::Number.number(digits: 2) }
    lsg_body_id { LsgBody.last.id }
  end
end
