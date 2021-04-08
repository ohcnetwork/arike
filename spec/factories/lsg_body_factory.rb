FactoryBot.define do
  factory :lsg_body, class: "LsgBody" do
    name { generate(:name) }
    kind { "Panchayat" }
    code { "101" }
    district { "district" }
  end
end
