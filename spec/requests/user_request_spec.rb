require "rails_helper"

RSpec.describe "Users", type: :request do
  it "creates a new user with correct details" do
    full_name = Faker::Name.name
    first_name = Faker::Name.first_name
    email = Faker::Internet.email
    post "/users", params: { user: { first_name: first_name, full_name: full_name, role: "asha", email: email, phone: Faker::Number.number(digits: 10), verified: false, password: "0" } }
    user = User.last
    expect(user.full_name).to eq(full_name)
    expect(user.first_name).to eq(first_name)
    expect(user.email).to eq(email)
  end
end
