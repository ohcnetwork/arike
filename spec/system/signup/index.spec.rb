require 'rails_helper'

RSpec.describe 'Signup feature' do
	it 'create new user' do
		visit new_user_registration_path
		expect(page).to have_content('Sign up new account')

		fill_in('user_first_name', with: 'John')
		fill_in('user_full_name', with: 'John Doe')
		select "ASHA", :from => "user_role"
		fill_in('user_email', with: 'johndoe@example.com')
		fill_in('user_phone', with: '9988776677')
		fill_in('user_password', with: 'JohnDoe')
	end
end