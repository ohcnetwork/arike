require "rails_helper"

RSpec.describe "Users", type: :request do
  before :each do
    @superuser = FactoryBot.create(:user, role: User.roles[:superuser], verified: true)
    post user_session_path, params: { user: { login_id: @superuser.email, password: @superuser.password } }
  end

  it "verify access of a signed up user by super user" do
    user = FactoryBot.create(:user, verified: false)
    put "/users/#{user.id}/verify"
    expect(User.find(user.id).verified).to eq(true)
  end

  it "verify edit of user details by super user" do
    user = FactoryBot.create(:user, verified: true)

    # making a deep copy
    old_user = Marshal.load(Marshal.dump(user))
    user.full_name = Faker::Name.name
    user.first_name = Faker::Name.first_name
    user.email = Faker::Internet.email
    user.phone = Faker::Number.number(digits: 10)
    put "/users/#{user.id}", params: { user: { first_name: user.first_name, full_name: user.full_name, role: user.role, email: user.email, phone: user.phone, verified: true } }
    final_user = User.find(user.id)
    expect(final_user.full_name).to eq(user.full_name)
    expect(final_user.full_name).not_to eq(old_user.full_name)
    expect(final_user.first_name).to eq(user.first_name)
    expect(final_user.first_name).not_to eq(old_user.first_name)
    expect(final_user.email).to eq(user.email)
    expect(final_user.phone).not_to eq(old_user.phone)
  end
end
