# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create!([
#   { first_name: "Pulkit", full_name: "Pulkit Ahuja", role: "asha", password: "0" },
#   { first_name: "Yash", full_name: "Yash Gupta", role: "asha", password: "0" },
#   { first_name: "Rajesh", full_name: "Rajesh Sharma", role: "asha", password: "0" },
#   { first_name: "Himanshu", full_name: "Himanshu", role: "asha", password: "0" },
#   { first_name: "Abhay", full_name: "Abhay Ahuja", role: "asha", password: "0" },
# ])

# User.create!([
#   { first_name: "Abhinandan", full_name: "Abhinandan Arya", role: "volunteer", password: "0" },
#   { first_name: "Tanishq", full_name: "Tanishq Agarwal", role: "volunteer", password: "0" },
#   { first_name: "Aman", full_name: "Aman Gupta", role: "volunteer", password: "0" },
#   { first_name: "Naveen", full_name: "Naveen Rohilla", role: "volunteer", password: "0" },
#   { first_name: "Raj", full_name: "Raj Mishra", role: "volunteer", password: "0" },
# ])

# User.create!([
#   { first_name: "Kajal", full_name: "Kajal Brar", role: "primary_nurse", password: "0" },
#   { first_name: "Ansh", full_name: "Ansh Aggarwal", role: "primary_nurse", password: "0" },
#   { first_name: "Darshana", full_name: "Darshana Thakkar", role: "primary_nurse", password: "0" },
#   { first_name: "Kalyani", full_name: "Kalyani Nayak", role: "primary_nurse", password: "0" },
#   { first_name: "Dhruv", full_name: "Dhruv Pathak", role: "primary_nurse", password: "0" },
# ])

# User.create!([
#   { first_name: "Pulkit", full_name: "Tara Vaidya", role: "secondary_nurse", password: "0" },
#   { first_name: "Nilam", full_name: "Nilam Natarajan", role: "secondary_nurse", password: "0" },
#   { first_name: "Jivika", full_name: "Jivika Malhotra", role: "secondary_nurse", password: "0" },
#   { first_name: "Sudhir", full_name: "Sudhir Kashyap", role: "secondary_nurse", password: "0" },
#   { first_name: "Kabir", full_name: "Kabir Munshi", role: "secondary_nurse", password: "0" },
# ])

# Panchayat/Municipliaty/Corporation
kinds = ["Panchayat", "Municipliaty", "Corporation"]
alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
i = 0
while i < 15
  name = ""
  j = 0
  while j < 3
    name += alphabet[rand(26)]
    j += 1
  end
  LsgBody.create!(name: name, kind: kinds[rand(3)])
  i += 1
end
