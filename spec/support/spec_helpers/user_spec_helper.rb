module UserSpecHelper

  def login_as(user)
    # post "/session", params: { session: { email: user.email, password: "password" } }
    visit new_user_session_path
    fill_in "Email or Phone Number", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
  end
end
