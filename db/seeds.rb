# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!([
  #{ first_name: "Pulkit", full_name: "Pulkit Ahuja", role: "asha", password: "0", email: "pulkit@gmail.com", phone: 1234567890 },
  { first_name: "Yash", full_name: "Yash Gupta", role: "asha", password: "0", email: "yash@gmail.com", phone: 2345678901 },
  { first_name: "Rajesh", full_name: "Rajesh Sharma", role: "asha", password: "0", email: "rajesh@gmail.com", phone: 3456789012 },
  { first_name: "Himanshu", full_name: "Himanshu", role: "asha", password: "0", email: "himanshu@gmail.com", phone: 4567890123 },
  { first_name: "Abhay", full_name: "Abhay Ahuja", role: "asha", password: "0", email: "abhay@gmail.com", phone: 5678901234 },
])

User.create!([
  { first_name: "Aniket", full_name: "Aniket Sharma", role: "volunteer", password: "0", email: "aniket@gmail.com", phone: 6789012345 },
  { first_name: "Tanishq", full_name: "Tanishq Agarwal", role: "volunteer", password: "0", email: "tanishq@gmail.com", phone: 7890123456 },
  { first_name: "Aman", full_name: "Aman Gupta", role: "volunteer", password: "0", email: "aman@gmail.com", phone: 8901234567 },
  { first_name: "Naveen", full_name: "Naveen Rohilla", role: "volunteer", password: "0", email: "naveen@gmail.com", phone: 90123456789 },
  { first_name: "Raj", full_name: "Raj Mishra", role: "volunteer", password: "0", email: "raj@gmail.com", phone: 1234506789 },
])

User.create!([
  { first_name: "Kajal", full_name: "Kajal Brar", role: "primary_nurse", password: "0", email: "kajal@gmail.com", phone: 5768901234 },
  { first_name: "Ansh", full_name: "Ansh Aggarwal", role: "primary_nurse", password: "0", email: "ansh@gmail.com", phone: 5678902134 },
  { first_name: "Darshana", full_name: "Darshana Thakkar", role: "primary_nurse", password: "0", email: "darshana@gmail.com", phone: 5678901243 },
  { first_name: "Kalyani", full_name: "Kalyani Nayak", role: "primary_nurse", password: "0", email: "kalyani@gmail.com", phone: 5678910234 },
  { first_name: "Dhruv", full_name: "Dhruv Pathak", role: "primary_nurse", password: "0", email: "dhruv@gmail.com", phone: 5678091234 },
])

User.create!([
  { first_name: "Tara", full_name: "Tara Vaidya", role: "secondary_nurse", password: "0", email: "tara@gmail.com", phone: 5679801234 },
  { first_name: "Nilam", full_name: "Nilam Natarajan", role: "secondary_nurse", password: "0", email: "nilam@gmail.com", phone: 5728901234 },
  { first_name: "Jivika", full_name: "Jivika Malhotra", role: "secondary_nurse", password: "0", email: "jivika@gmail.com", phone: 5698701234 },
  { first_name: "Sudhir", full_name: "Sudhir Kashyap", role: "secondary_nurse", password: "0", email: "sudhir@gmail.com", phone: 56712341234 },
  { first_name: "Kabir", full_name: "Kabir Munshi", role: "secondary_nurse", password: "0", email: "kabir@gmail.com", phone: 5675364334 },
])

# Panchayat/Municipliaty/Corporation
kinds = ["Panchayat", "Municipliaty", "Corporation"]
alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
i = 0
while i < 15
  name = ""
  code = ""
  district = ""
  j = 0
  while j < 3
    name += alphabet[rand(26)]
    code += alphabet[rand(5)]
    district += alphabet[rand(10)] + alphabet[rand(10)] + alphabet[rand(10)]
    j += 1
  end
  LsgBody.create!(name: name, kind: kinds[rand(3)], code: code, district: district)
  i += 1
end

# # SuperUser
# User.create!([
#   { first_name: "Admin", full_name: "Admin User", role: "superuser", email: "admin@arike.com", phone: 123456789, verified: true, password: "0" },
# ])
