require 'rails_helper'

feature 'Facility index spec' do
  include UserSpecHelper

  before(:all) do
    FactoryBot.create(:state)
    FactoryBot.create(:district)
    FactoryBot.create(:lsg_body)
    FactoryBot.create(:ward)
    (1..20).each do
        FactoryBot.create(:facility, kind: 'CHC')
    end
  end

  context 'When an superuser signs in', js: true do
    before(:all) do
      @superuser = FactoryBot.create(:user, role: User.roles[:superuser], verified: true)
    end

    scenario "Visiting the facility page" do
      login_as(@superuser)

      expect(page).to have_text("Dashboard")
      within("#dashboard-tiles") do
        click_link("Facilities")
        expect(page).to have_text("Facilities")
      end
      
    end
  end
end