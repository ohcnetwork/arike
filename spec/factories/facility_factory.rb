FactoryBot.define do
  factory :facility, class: 'Facility' do
    kind { 'PHC' }
    name { Faker::Name.first_name }
    state_id { State.last.id }
    district_id { District.last.id }
    lsg_body_id { LsgBody.last.id }
    ward_id { Ward.last.id }
    address { 'Test Address Body' }
    pincode { Faker::Number.number(digits: 7) }
    phone { Faker::Number.number(digits: 10) }
  end
end
