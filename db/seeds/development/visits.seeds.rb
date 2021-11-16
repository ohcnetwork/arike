after "development:users", "development:patients" do
  Patient.all.each do |patient|
    first_visit = Date.today - Random.rand(15)
    Visit.create!(
      created_at: DateTime.now,
      updated_at: DateTime.now,
      first_visit: first_visit,
      last_visit: first_visit,
      records: {},
      next_visit: nil,
      patient_id: patient.id,
      user_id: User.first.id,
      expected_visit: Date.today + Random.rand(7)
    )
  end
end