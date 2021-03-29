require 'rails_helper'

feature 'Index spec' do
  include UserSpecHelper

  context 'When an superuser signs in', js: true do
    before do
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
  end

  context 'When a Secondary nurse signs in ', js: true do
    before do
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
  end
end
