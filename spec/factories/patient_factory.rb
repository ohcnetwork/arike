FactoryBot.define do
	factory :patient, class: 'Patient' do
    full_name { generate(:full_name) }
    phone { Faker::Number.number(digits: 10) }
    emergency_phone_no { Faker::Number.number(digits: 10) }
    facility_id { Facility.last.id }
  end
end