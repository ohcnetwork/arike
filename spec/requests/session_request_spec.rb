require "rails_helper"

RSpec.describe "Sessions", type: :request do
  it "creates a new session" do
    password = "random"
    user = FactoryBot.create(:volunteer, password: password)
    post user_session_path, params: { user: { login_id: user.email, password: password } }
    expect(response).to redirect_to(dashboard_path)
  end

  it "validates the password" do
    invalid_password = "something"
    user = FactoryBot.create(:volunteer)
    post user_session_path, params: { user: { login_id: user.email, password: invalid_password } }
    expect(response.body).to include("Invalid Login or password")
  end
end
