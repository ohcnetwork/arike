require 'rails_helper'

feature 'Dashboard view for different users', js: true do
  include UserSpecHelper

  before(:all) do
    20.times do
      create(:user, role: User.roles[User.roles.keys.sample], verified: true)
    end
  end

  context 'When an superuser signs in' do
    before(:all) do
      @superuser = create(:user, role: User.roles[:superuser], verified: true)
    end

    scenario 'Dashboard for superuser' do
      login_as(@superuser)

      expect(page).to have_text('Wards')
      expect(page).to have_text('LSGs')
    end

    scenario 'Adding new users' do
      login_as(@superuser)

      visit new_user_path
      expect(page).to have_select('Role', options: ['Superuser', 'Primary Nurse', 'Secondary Nurse', 'ASHA', 'Volunteer'])
    end

    scenario 'Viewing user details' do
      login_as(@superuser)

      visit users_path
      expect(page).to have_text('Unverified Users')
      expect(page).to have_text('Superuser')
    end
  end

  context 'When a secondary nurse signs in' do
    before(:all) do
      @secondary_nurse = create(:user, role: User.roles[:secondary_nurse], verified: true)
    end

    scenario 'Dashboard for nurse' do
      login_as(@secondary_nurse)

      expect(page).not_to have_text('Wards')
      expect(page).not_to have_text('LSGs')
    end

    scenario 'Adding new users' do
      login_as(@secondary_nurse)

      visit new_user_path
      expect(page).not_to have_select('Role', options: ['Superuser', 'Secondary Nurse'])
      expect(page).to have_select('Role', options: ['Primary Nurse', 'ASHA', 'Volunteer'])
    end

    scenario 'Viewing user details' do
      login_as(@secondary_nurse)

      visit users_path
      expect(page).not_to have_text('Unverified Users')
      expect(page).not_to have_text('Superuser')
      expect(page).to have_text('Secondary Nurse')
    end
  end

  context 'When a primary nurse signs in' do
    before(:all) do
      @primary_nurse = create(:user, role: User.roles[:primary_nurse], verified: true)
    end

    scenario 'Dashboard for nurse' do
      login_as(@primary_nurse)

      expect(page).not_to have_text('Wards')
      expect(page).not_to have_text('LSGs')
    end

    scenario 'Adding new users' do
      login_as(@primary_nurse)

      visit new_user_path
      expect(page).not_to have_select('Role', options: ['Superuser', 'Secondary Nurse', 'Primary Nurse'])
      expect(page).to have_select('Role', options: ['ASHA', 'Volunteer'])
    end

    scenario 'Viewing user details' do
      login_as(@primary_nurse)

      visit users_path
      expect(page).not_to have_text('Unverified Users')
      expect(page).not_to have_text('Superuser')
      expect(page).not_to have_text('Secondary Nurse')
      expect(page).to have_text('Primary Nurse')
    end
  end
end
