require 'rails_helper'

feature 'Create New Facility', js: true do
  include UserSpecHelper

  before(:all) do
    FactoryBot.create(:state, name: "Kerala")
    (1..5).each do
      FactoryBot.create(:district)
      FactoryBot.create(:lsg_body)
      FactoryBot.create(:ward)
      FactoryBot.create(:facility, kind: 'CHC')
    end

    @name = Faker::Name.first_name
    @address = Faker::Address.full_address
    @state = "Kerala"
    @district = District.last
    @lsg = LsgBody.last
    @ward = Ward.last
    @pincode = Faker::Number.number(digits: 7)
    @phone = Faker::Number.number(digits: 10)
    @chc = Facility.where(kind: "CHC").last.name
  end

  context 'When an superuser signs in' do
    before do
      @superuser = FactoryBot.create(:user, role: User.roles[:superuser], verified: true)
      login_as(@superuser)
      visit facilities_path
    end

    scenario "Creating a PHC with linked CHC" do
      click_link("New Facility")
      expect(page).to have_text("New Facility")

      select "PHC", :from => "facility[kind]" 
      fill_in "Name", :with => @name
      select @state, :from => "facility[state_id]" 
      select @district.name, :from => "facility[district_id]"
      select @lsg.name, :from => "facility[lsg_body_id]"
      select @ward.number, :from => "facility[ward_id]"
      fill_in "Address", :with => @address
      fill_in "Pincode", :with => @pincode
      fill_in "Phone", :with => @phone
      select @chc, :from => "facility[parent_id]" 

      click_button "Create Facility"
      
      expect(page).to have_text(@name)
      expect(page).to have_text(@state)
      expect(page).to have_text("+91 #{@phone}")
      expect(page).to have_text(@pincode)
      expect(page).to have_text(@address)
      expect(page).to have_text(@ward.name)
    end

    scenario "Creating a CHC" do
      click_link("New Facility")
      expect(page).to have_text("New Facility")
      sleep 100
      select "CHC", :from => "facility[kind]" 
      fill_in "Name", :with => @name
      select @state, :from => "facility[state_id]" 
      select @district.name, :from => "facility[district_id]"
      select @lsg.name, :from => "facility[lsg_body_id]"
      select @ward.number, :from => "facility[ward_id]"
      fill_in "Address", :with => @address
      fill_in "Pincode", :with => @pincode
      fill_in "Phone", :with => @phone
    
      click_button "Create Facility"
      
      expect(page).to have_text(@name)
      expect(page).to have_text(@state)
      expect(page).to have_text("+91 #{@phone}")
      expect(page).to have_text(@pincode)
      expect(page).to have_text(@address)
      expect(page).to have_text(@ward.name)
      # expect(page).to have_text(@lsgBody.name)
    end
  end
end