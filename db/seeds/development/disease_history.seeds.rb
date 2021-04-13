after "development:users" do
  Patient.all.each do |patient|
    diseases_names = Disease.all.map {|d| d.id}
    (1..5).each do |i|
      PatientDiseaseSummary.create(
        patient_id: patient.id,
        name: diseases_names[rand(diseases_names.length)],
        date_of_diagnosis: DateTime.now-10000*i,
        investigation: Faker::Name.name,
        treatments: Faker::Name.name,
        remarks:Faker::Name.name
      )
    end
  end
end
