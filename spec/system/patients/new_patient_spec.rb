require 'rails_helper'

feature 'Create Patient spec' do
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

  context 'For a superuser', js: true do
    before do
      @user = FactoryBot.create(:user, role: User.roles[:superuser], verified: true)
      login_as(@user)

      within(find("div.desktopLayoutSidebar")) do
        click_on("Enroll New Patients")
      end

      expect(page).to have_text("Create Patient")
    end

    scenario 'Creating a new patient' do
      name = generate(:full_name)
      dob = Faker::Date.in_date_period
      gender = ["Male", "Female", "Other"].sample
      phone = Faker::Number.number(digits: 10)
      emergency = Faker::Number.number(digits: 10)
      facility = Facility.last.name
      route = Faker::Address.full_address
      address = Faker::Address.full_address
      notes = Faker::Lorem.paragraph
      volunteer = User.where(role: "Volunteer").last
      economic_status = ["Well Off", "Middle Class", "Poor", "Very Poor"].sample

      fill_in "patient[full_name]", with: name
      fill_in "patient[dob]", with: dob
      select gender, from: "patient[gender]"
      fill_in "patient[phone]", with: phone
      fill_in "patient[emergency_phone_no]", with: emergency
      select facility, from: "patient[facility_id]"
      fill_in "patient[route]", with: route
      fill_in "patient[address]", with: address
      fill_in "patient[notes]", with: notes
      select economic_status, from: "patient[economic_status]"

      within(find("div.actions")) do
        click_on("Submit")
      end

      expect(page).to have_text("Patients")
      expect(page).to have_text(name)
      expect(page).to have_text(dob)
      expect(page).to have_text(phone)
      expect(page).to have_text(address)
    end
  end
end
