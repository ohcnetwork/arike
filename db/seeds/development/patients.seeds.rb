after 'development:facilities', 'development:users' do
  (1..20).each do |index|
    Patient.create!(
      full_name: Faker::Name.name,
      dob: Faker::Date.between(from: '1947-09-23', to: DateTime.now),
      address: Faker::Name.name,
      route: Faker::Name.name,
      phone: rand((10**10)..(10**11 - 1)),
      economic_status:
        Patient.economic_statuses.values[
          rand(Patient.economic_statuses.length)
        ],
      notes: Faker::Name.name,
      created_by: User.all[rand(User.count)].id,
      facility_id: Facility.all[rand(Facility.count)].id,
      gender: %w[Male Female Others][rand(3)],
      emergency_phone_no: rand((10**10)..(10**11 - 1)),
      disease: Faker::Name.name,
      patient_views: Faker::Name.name,
      family_views: Faker::Name.name,
      expired: nil,
    )
  end
end
