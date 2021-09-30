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

    # Edit Personal Details of Patient
    scenario 'Edit Name of Patient' do
      @user = FactoryBot.create(:user, role: User.roles[:superuser], verified: true)
      login_as(@user)

      @patient = Patient.last
      within(find("div.desktopLayoutSidebar")) do
        click_on("Patients")
      end

      click_on("View")
      click_on("Edit Personal Details")

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
      # find("label[name='patient[volunteer[#{volunteer.id}]]']").click
      select economic_status, from: "patient[economic_status]"

      within(find("div.actions")) do
        click_on("Submit")
      end

      click_on("Personal Details")

      expect(page).to have_text("Patients")
      expect(page).to have_text(name)
      expect(page).to have_text(dob)
      expect(page).to have_text(phone)
      expect(page).to have_text(address)
    end

    # Edit Family Details of Patient
    scenario 'Edit Name of Patient' do
      @user = FactoryBot.create(:user, role: User.roles[:superuser], verified: true)
      login_as(@user)

      @patient = Patient.last
      within(find("div.desktopLayoutSidebar")) do
        click_on("Patients")
      end

      click_on("View")
      click_on("Edit Family Details")

      name = generate(:full_name)
      dob = Faker::Date.in_date_period
      relationship = ["Mother", "Father", "Sister", "Brother"].sample
      phone = Faker::Number.number(digits: 10)
      education = ["Uneducated", "10th Standard", "12th Standard", "Graduate"].sample
      occupation = ["Jobless", "Public Servant", "Private Job", "Business"].sample

      fill_in "familyDetails[1][full_name]", with: name
      select relationship, from: "familyDetails[1][relation]"
      fill_in "familyDetails[1][dob]", with: dob
      fill_in "familyDetails[1][phone]", with: phone
      select education, from: "familyDetails[1][education]"
      select occupation, from: "familyDetails[1][occupation]"

      click_on("Save")

      click_on("Family Details")

      expect(page).to have_text("Patients")
      expect(page).to have_text(name)
      expect(page).to have_text(dob)
      expect(page).to have_text(phone)
    end
  end
end
