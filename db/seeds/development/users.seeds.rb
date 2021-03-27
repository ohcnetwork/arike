(1..20).each do |index|
  User.create!(
    first_name: Faker::Name.first_name,
    full_name: Faker::Name.name,
    role: User.roles.values.sample,
    password: "0",
    email: "user#{index}@example.com",
    phone: rand(10 ** 10),
  )
end
