require "rails_helper"

RSpec.describe "Users", type: :request do
  before :all do
    @superuser = FactoryBot.create(:user, role: "superuser", verified: true)
    post "/sessions", params: { user: { login_id: @superuser.email, password: @superuser.password } }
  end

  it "verify access of a signed up user by super user" do
    user = FactoryBot.create(:user, verified: false)
    session_params = { current_user_id: @superuser.id }
    put "/users/#{user.id}/verify"
    expect(User.find_by_id(user.id).verified).to eq(true)
  end
end
