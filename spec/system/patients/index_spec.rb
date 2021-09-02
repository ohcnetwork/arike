require 'rails_helper'

feature 'Index spec' do
  include UserSpecHelper

  before(:all) do
    FactoryBot.create(:state)
    FactoryBot.create(:district)
    FactoryBot.create(:lsg_body)
    FactoryBot.create(:ward)
    FactoryBot.create(:facility, kind: 'CHC')
    @patient = FactoryBot.create(:patient)
    @user = FactoryBot.create(:user, role: User.roles[:superuser], verified: true)
  end

  context 'Superuser', js: true do
    scenario 'View Patients' do
      login_as(@user)

      within(find("div.desktopLayoutSidebar")) do
        click_on("Patients")
      end

      expect(page).to have_text('Patients')
      expect(page).to have_text(@user.full_name)
    end

    scenario 'View Patient Information' do
      login_as(@user)

      within(find("div.desktopLayoutSidebar")) do
        click_on("Patients")
      end


      click_on("View")
      expect(page).to have_text(@user.full_name)

    end
  end
end
