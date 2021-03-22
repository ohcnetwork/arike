require "rails_helper"

RSpec.describe "Users", type: :request do
  it "prevents creating a new user without superuser privileges" do
    full_name = Faker::Name.name
    first_name = Faker::Name.first_name
    email = Faker::Internet.email
    post "/users", params: { user: { first_name: first_name, full_name: full_name, role: User.roles[:asha], email: email, phone: Faker::Number.number(digits: 10), verified: false, password: "0" } }
    user = User.last
    expect(user).to eq(nil)
  end

  it "prevents verify access of a unverified user without superuser privilege" do
    user = FactoryBot.create(:user, verified: false)
    put "/users/:id/verify", params: { id: user.id }
    expect(User.find_by_id(user.id).verified).to eq(false)
    expect(response).to redirect_to("/")
  end
end
