kinds = ["Panchayat", "Municipliaty", "Corporation"]
Faker::Config.locale = "en-IND"

(1..15).each do |index|
  LsgBody.create!(name: Faker::Name.name, kind: kinds.sample, code: Faker::Name.name, district: Faker::Name.name)
end

(1..20).each do |index|
  User.create!(first_name: Faker::Name.name, full_name: Faker::Name.name, role: User.roles.values.sample, password: "0", email: "user#{index}@example.com", phone: rand(10 ** 10))
end

# SuperUser
User.create!(first_name: Faker::Name.name, full_name: Faker::Name.name, role: User.roles[:superuser], password: "0", verified: true, email: "admin@arike.com", phone: rand(10 ** 10))

LsgBody.all.each do |lsg|
  (1..3).each do |index|
    Ward.create!(name: Faker::Name.name, number: index, lsg_body_id: lsg.id)
  end

  Facility.create!(
    kind: "CHC", name: Faker::Name.name, state: "Kerala", district: "Ernakulum", lsg_body: lsg.id, ward: lsg.wards.last.id,
  )

  Facility.create!(
    kind: "PHC", name: Faker::Name.name, state: "Kerala", district: "Ernakulum", lsg_body: lsg.id, ward: lsg.wards.last.id, parent_id: Facility.first.id,
  )
end


# Facility.limit(3).each do |facility|
#   (21..24).each do |index|
#     User.create!(first_name: Faker::Name.name, full_name: Faker::Name.name, role: User.roles[:primary_nurse], password: "0", verified: true, email: "pn#{index}@example.com", phone: rand(10 ** 10), facility_id: facility.id)
#   end
# end

# Facility.where(kind: "CHC").limit(3).each do |facility|
#   (25..28).each do |index|
#     User.create!(first_name: Faker::Name.name, full_name: Faker::Name.name, role: User.roles[:secondary_nurse], password: "0", verified: true, email: "sn#{index}@example.com", phone: rand(10 ** 10), facility_id: facility.id)
#   end
# end

User.create!(first_name: Faker::Name.name, full_name: Faker::Name.name, role: User.roles[:primary_nurse], password: "0", verified: true, email: "pn@example.com", phone: rand(10 ** 10), facility_id: Facility.first.id)
User.create!(first_name: Faker::Name.name, full_name: Faker::Name.name, role: User.roles[:secondary_nurse], password: "0", verified: true, email: "pn@example.com", phone: rand(10 ** 10), facility_id: Facility.second.id)
