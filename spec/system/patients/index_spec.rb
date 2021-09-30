require 'rails_helper'

feature 'Index spec' do
  include UserSpecHelper

  before(:each) do
    FactoryBot.create(:state)
    FactoryBot.create(:district)
    FactoryBot.create(:lsg_body)
    FactoryBot.create(:ward)
    FactoryBot.create(:facility, kind: 'CHC')
    FactoryBot.create(:patient)
    (1...5).each do
      FactoryBot.create(:volunteer)
    end
  end

  context 'Superuser', js: true do
    scenario 'View Patients' do
      @user = FactoryBot.create(:user, role: User.roles[:superuser], verified: true)
      login_as(@user)

      within(find("div.desktopLayoutSidebar")) do
        click_on("Patients")
      end

      expect(page).to have_text('Patients')
    end

    scenario 'View Patient Information' do
      @user = FactoryBot.create(:user, role: User.roles[:superuser], verified: true)
      login_as(@user)

      @patient = Patient.last
      within(find("div.desktopLayoutSidebar")) do
        click_on("Patients")
      end

      click_on("View")
      expect(page).to have_text(@patient.full_name)

    end
  end
end
