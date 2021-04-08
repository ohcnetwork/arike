kinds = ["Panchayat", "Municipliaty", "Corporation"]
(1..15).each do |index|
  LsgBody.create!(name: Faker::Name.name, kind: kinds.sample, code: Faker::Name.name, district: Faker::Name.name)
end
