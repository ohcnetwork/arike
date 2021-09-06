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
    @family_member = FactoryBot.create(:family_details, patient_id: @patient.id)
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
      expect(page).to have_text(@patient.full_name)

    end

    scenario "View Personal Details of Patient" do
      login_as(@user)

      within(find("div.desktopLayoutSidebar")) do
        click_on("Patients")
      end


      click_on("View")

      click_on("Personal Details")

      expect(page).to have_text(@patient.full_name)
      expect(page).to have_text(@patient.dob)
      expect(page).to have_text(@patient.phone)
      expect(page).to have_text(@patient.address)
      expect(page).to have_text(@patient.route)
    end

    scenario "View Family Details of Patient" do
      login_as(@user)

      within(find("div.desktopLayoutSidebar")) do
        click_on("Patients")
      end


      click_on("View")

      click_on("Family Details")

      expect(page).to have_text(@family_member.full_name)
      expect(page).to have_text(@family_member.phone)
      expect(page).to have_text(@family_member.relation)
    end
  end
end
