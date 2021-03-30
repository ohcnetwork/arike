require 'rails_helper'

feature 'Index spec' do
  include UserSpecHelper

  before(:all) do
    (1..20).each do
        FactoryBot.create(:user, role: User.roles[User.roles.keys.sample], verified: true)
      end
  end

  context 'When an superuser signs in', js: true do
    before(:all) do
      @superuser = FactoryBot.create(:user, role: User.roles[:superuser], verified: true)
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
      expect(page).to have_text('Superuser')
      expect(page).to have_text('Secondary Nurse')
      expect(page).to have_text('Primary Nurse')
      expect(page).to have_text('ASHA')
      expect(page).to have_text('Volunteer')
    end
  end

  context 'When a Secondary nurse signs in ', js: true do
    before(:all) do
      @secondary_nurse = FactoryBot.create(:user, role: User.roles[:secondary_nurse], verified: true)
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
      expect(page).not_to have_text('Superuser')
      expect(page).to have_text('Secondary Nurse')
      expect(page).to have_text('Primary Nurse')
      expect(page).to have_text('ASHA')
      expect(page).to have_text('Volunteer')
    end
  end

  context 'When a Primary nurse signs in ', js: true do
    before do
      @primary_nurse = FactoryBot.create(:user, role: User.roles[:primary_nurse], verified: true)
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
      expect(page).not_to have_text('Superuser')
      expect(page).not_to have_text('Secondary Nurse')
      expect(page).to have_text('Primary Nurse')
      expect(page).to have_text('ASHA')
      expect(page).to have_text('Volunteer')
    end
  end
end
