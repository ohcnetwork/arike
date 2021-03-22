require "rails_helper"

RSpec.describe "Sessions", type: :request do
  it "creates a new session" do
    password = "random"
    user = FactoryBot.create(:volunteer, password: password)
    post "/sessions", params: { user: { login_id: user.email, password: password } }
    expect(response).to redirect_to("/dashboard")
    follow_redirect!
    expect(session[:current_user_id]).to eq(user.id)
  end

  it "validates the password" do
    INVALID_PASSWORD = "something"
    user = FactoryBot.create(:volunteer)
    post "/sessions", params: { user: { login_id: user.email, password: INVALID_PASSWORD } }
    expect(response).to redirect_to("/sessions")
    follow_redirect!
    expect(response.body).to include("Invalid Credentials!")
    expect(session[:current_user_id]).to eq(nil)
  end

  it "sign up a new user" do
    full_name = Faker::Name.name
    first_name = Faker::Name.first_name
    email = Faker::Internet.email
    post "/sessions/signup", params: { user: { first_name: first_name, full_name: full_name, role: User.roles[:asha], email: email, phone: Faker::Number.number(digits: 10), verified: false, password: "0" } }
    user = User.last
    expect(user.full_name).to eq(full_name)
    expect(user.first_name).to eq(first_name)
    expect(user.email).to eq(email)
  end
end
