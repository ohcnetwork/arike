require 'rails_helper'

feature 'Index spec' do
  include UserSpecHelper

  context 'Superuser', js: true do
    scenario 'View Patients' do
      login_as("admin@arike.com", "check12345")

      within(find("div.desktopLayoutSidebar")) do
        click_on("Patients")
      end

      expect(page).to have_text('Patients')
    end

    # scenario 'View Patient Information' do
    #   login_as("admin@arike.com", "check12345")

    #   within(find("div.desktopLayoutSidebar")) do
    #     click_on("Patients")
    #   end


    #   click_on("View")
    #   expect(page).to have_text(@patient.full_name)

    # end
  end
end
