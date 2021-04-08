after "development:facilities" do
  if !User.find_by(email: "admin@arike.com")
    User.create!(
      first_name: Faker::Name.first_name,
      full_name: Faker::Name.name,
      role: User.roles[:superuser],
      password: "0",
      verified: true,
      email: "admin@arike.com",
      phone: rand(10 ** 10),
    )
  end
end
