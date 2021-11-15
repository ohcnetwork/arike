after "development:superuser" do
  (1..20).each do |index|
    User.create!(
      full_name: Faker::Name.name,
      role: User.roles.values.sample,
      encrypted_password: "password",
      password: "password",
      email: Faker::Internet.email,
      phone: rand(10 ** 10),
    )
  end
end
