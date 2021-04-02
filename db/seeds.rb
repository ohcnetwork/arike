# kinds = ["Panchayat", "Municipliaty", "Corporation"]
# Faker::Config.locale = "en-IND"

# (1..15).each do |index|
#   LsgBody.create!(name: Faker::Name.name, kind: kinds.sample, code: Faker::Name.name, district: Faker::Name.name)
# end


# (1..20).each do |index|
#   User.create!(first_name: Faker::Name.name, full_name: Faker::Name.name, role: User.roles.values.sample, password: "0", email: "user#{index}@example.com", phone: rand(10 ** 10))
# end


# # SuperUser
# # User.create!(first_name: Faker::Name.name, full_name: Faker::Name.name, role: User.roles[:superuser], password: "0", verified: true, email: "admin@arike.com", phone: rand(10 ** 10))

# LsgBody.all.each do |lsg|
#   (1..3).each do |index|
#     Ward.create!(name: Faker::Name.name, number: index, lsg_body_id: lsg.id)
#   end

#   Facility.create!(
#     kind: "CHC", name: Faker::Name.name, state: "Kerala", district: "Ernakulum", lsg_body: lsg.id, ward: lsg.wards.last.id,
#   )

#   Facility.create!(
#     kind: "PHC", name: Faker::Name.name, state: "Kerala", district: "Ernakulum", lsg_body: lsg.id, ward: lsg.wards.last.id, parent_id: Facility.first.id,
#   )
# end

# Seed Diseases= DM/Hypertension/IHD/COPD/Dementia/CVA/Cancer/CKD
Disease.create!(name: "DM", icds_code: "D-32")
Disease.create!(name: "Hypertension", icds_code: "HT-58")
Disease.create!(name: "IHD", icds_code: "IDH-21")
Disease.create!(name: "COPD", icds_code: "DPOC-144")
Disease.create!(name: "Dementia", icds_code: "DM-62")
Disease.create!(name: "CVA", icds_code: "CAV-89")
Disease.create!(name: "Cancer", icds_code: "C-98")
Disease.create!(name: "CKD", icds_code: "DC-25")
