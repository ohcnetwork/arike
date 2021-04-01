LsgBody.all.each do |lsg|
  (1..3).each do |index|
    Ward.create!(name: Faker::Name.name, number: index, lsg_body_id: lsg.id)
  end

  Facility.create!(
    kind: "PHC",
    name: Faker::Name.name,
    state: "Kerala",
    district: "Ernakulum",
    lsg_body_id: lsg.id,
    ward_id: lsg.wards.last.id,
  )
end
