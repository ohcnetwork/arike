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
    invalid_password = "something"
    user = FactoryBot.create(:volunteer)
    post "/sessions", params: { user: { login_id: user.email, password: invalid_password } }
    expect(response).to redirect_to("/sessions/new")
    follow_redirect!
    expect(response.body).to include("Invalid Credentials!")
    expect(session[:current_user_id]).to eq(nil)
  end
end
