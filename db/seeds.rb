# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!([
  {first_name: "Pulkit", full_name: "Pulkit Ahuja", role: "asha"},
  {first_name: "Yash", full_name: "Yash Gupta", role: "asha"},
  {first_name: "Rajesh", full_name: "Rajesh Sharma", role: "asha"},
  {first_name: "Himanshu", full_name: "Himanshu", role: "asha"},
  {first_name: "Abhay", full_name: "Abhay Ahuja", role: "asha"},
])

User.create!([
  {first_name: "Abhinandan", full_name: "Abhinandan Arya", role: "volunteer"},
  {first_name: "Tanishq", full_name: "Tanishq Agarwal", role: "volunteer"},
  {first_name: "Aman", full_name: "Aman Gupta", role: "volunteer"},
  {first_name: "Naveen", full_name: "Naveen Rohilla", role: "volunteer"},
  {first_name: "Raj", full_name: "Raj Mishra", role: "volunteer"},
])

User.create!([
  {first_name: "Kajal", full_name: "Kajal Brar", role: "primary_nurse"},
  {first_name: "Ansh", full_name: "Ansh Aggarwal", role: "primary_nurse"},
  {first_name: "Darshana", full_name: "Darshana Thakkar", role: "primary_nurse"},
  {first_name: "Kalyani", full_name: "Kalyani Nayak", role: "primary_nurse"},
  {first_name: "Dhruv", full_name: "Dhruv Pathak", role: "primary_nurse"},
])

User.create!([
  {first_name: "Pulkit", full_name: "Tara Vaidya", role: "secondary_nurse"},
  {first_name: "Nilam", full_name: "Nilam Natarajan", role: "secondary_nurse"},
  {first_name: "Jivika", full_name: "Jivika Malhotra", role: "secondary_nurse"},
  {first_name: "Sudhir", full_name: "Sudhir Kashyap", role: "secondary_nurse"},
  {first_name: "Kabir", full_name: "Kabir Munshi", role: "secondary_nurse"},
])
