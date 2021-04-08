after "development:lsg_bodies" do
  LsgBody.all.each do |lsg|
    (1..3).each do |index|
      Ward.create!(name: Faker::Name.name, number: index, lsg_body_id: lsg.id)
    end

    Facility.create!(
      kind: Facility.kinds[:secondary], name: Faker::Name.name, state: "Kerala", district: "Ernakulum", address: "Test CHC Address", phone: Faker::Number.number(digits: 10), pincode: Faker::Number.number(digits: 7), lsg_body_id: lsg.id, ward_id: lsg.wards.last.id,
    )

    Facility.create!(
      kind: Facility.kinds[:primary], name: Faker::Name.name, state: "Kerala", district: "Ernakulum", address: "Test PHC Address", phone: Faker::Number.number(digits: 10), pincode: Faker::Number.number(digits: 7), lsg_body_id: lsg.id, ward_id: lsg.wards.last.id, parent_id: Facility.first.id,
    )
  end
end
