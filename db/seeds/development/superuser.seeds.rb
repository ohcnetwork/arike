after "development:facilities" do
  if !User.find_by(email: "admin@arike.com")
    User.create!(
      full_name: Faker::Name.name,
      role: User.roles[:superuser],
      encrypted_password: "Superpassword",
      password: "password",
      verified: true,
      email: "admin@arike.com",
      phone: rand(10 ** 10),
    )
  end
end
