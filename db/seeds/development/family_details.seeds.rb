after "development:patients" do
  Patient.all.each do |patient|
    (1..5).each do |i|
      FamilyDetail.create(
        patient_id: patient.id,
        full_name: Faker::Name.name,
        phone: rand((10 ** 10)..(10 ** 11 - 1)),
        dob: DateTime.now-rand(100000),
        relation: FamilyDetail.relations.values[rand(FamilyDetail.relations.length)],
        address: Faker::Name.name,
        education: FamilyDetail.educations.values[rand(FamilyDetail.educations.length)],
        occupation: FamilyDetail.occupations.values[rand(FamilyDetail.occupations.length)],
        remarks: Faker::Name.name
      )
    end
  end
end
