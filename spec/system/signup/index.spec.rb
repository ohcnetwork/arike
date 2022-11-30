require 'rails_helper'

RSpec.describe 'Signup feature' do
	it 'should create new user successfully' do
		visit new_user_registration_path
		expect(page).to have_content('Sign up new account')

		fill_in('user_full_name', with: 'John Doe')
		select "ASHA", :from => "user_role"
		fill_in('user_email', with: 'johndoe@example.com')
		fill_in('user_phone', with: '9988776677')
		fill_in('user_password', with: 'JohnDoe')

		click_button('Sign Up', exact: true)
		expect(current_path).to eql('/')

		expect(page).to have_content('Your account is not verified!')
	end

	it 'should not create user due to no email' do
		visit new_user_registration_path
		expect(page).to have_content('Sign up new account')

		fill_in('user_full_name', with: 'John Doe')
		select "ASHA", :from => "user_role"
		fill_in('user_phone', with: '9988776677')
		fill_in('user_password', with: 'JohnDoe')

		click_button('Sign Up', exact: true)
		expect(current_path).to eql('/users')

		expect(page).to have_content("Attention needed")
		expect(page).to have_content("Email can't be blank")
	end

	it 'should not create user due to no password' do
		visit new_user_registration_path
		expect(page).to have_content('Sign up new account')

		fill_in('user_full_name', with: 'John Doe')
		select "ASHA", :from => "user_role"
		fill_in('user_email', with: 'johndoe@example.com')
		fill_in('user_phone', with: '9988776677')

		click_button('Sign Up', exact: true)
		expect(current_path).to eql('/users')

		expect(page).to have_content("Attention needed")
		expect(page).to have_content("Password can't be blank")
	end

	it 'should not create user due to short password' do
		visit new_user_registration_path
		expect(page).to have_content('Sign up new account')

		fill_in('user_full_name', with: 'John Doe')
		select "ASHA", :from => "user_role"
		fill_in('user_email', with: 'johndoe@example.com')
		fill_in('user_phone', with: '9988776677')
		fill_in('user_password', with: 'John')

		click_button('Sign Up', exact: true)
		expect(current_path).to eql('/users')

		expect(page).to have_content("Attention needed")
		expect(page).to have_content("Password is too short (minimum is 6 characters)")
	end

	it 'should not create user due to duplicate email' do
		visit new_user_registration_path
		expect(page).to have_content('Sign up new account')

		fill_in('user_full_name', with: 'John Doe')
		select "ASHA", :from => "user_role"
		fill_in('user_email', with: 'johndoe@example.com')
		fill_in('user_phone', with: '9988776677')
		fill_in('user_password', with: 'JohnDoe')

		click_button('Sign Up', exact: true)
		expect(current_path).to eql('/')

		visit new_user_registration_path
		expect(page).to have_content('Sign up new account')

		fill_in('user_full_name', with: 'John Doe')
		select "ASHA", :from => "user_role"
		fill_in('user_email', with: 'johndoe@example.com')
		fill_in('user_phone', with: '99887766')
		fill_in('user_password', with: 'JohnDoe')

		click_button('Sign Up', exact: true)
		expect(current_path).to eql('/users')

		expect(page).to have_content("Attention needed")
		expect(page).to have_content("Email has already been taken")
	end

	it 'should not create user due to duplicate phone numbers' do
		visit new_user_registration_path
		expect(page).to have_content('Sign up new account')

		fill_in('user_full_name', with: 'John Doe')
		select "ASHA", :from => "user_role"
		fill_in('user_email', with: 'johndoe@example.com')
		fill_in('user_phone', with: '9988776677')
		fill_in('user_password', with: 'JohnDoe')

		click_button('Sign Up', exact: true)
		expect(current_path).to eql('/')

		visit new_user_registration_path
		expect(page).to have_content('Sign up new account')

		fill_in('user_full_name', with: 'John Doe2')
		select "ASHA", :from => "user_role"
		fill_in('user_email', with: 'johndoe2@example.com')
		fill_in('user_phone', with: '9988776677')
		fill_in('user_password', with: 'JohnDoe2')

		click_button('Sign Up', exact: true)
		expect(current_path).to eql('/users')

		expect(page).to have_content("Attention needed")
		expect(page).to have_content("Phone has already been taken")
	end

end 