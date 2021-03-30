module UserSpecHelper

  def login_as(user)
    visit new_session_path
    fill_in "Email or Phone Number", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign In"
  end
end
