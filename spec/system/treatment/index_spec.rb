require "rails_helper"
require "pry"

feature "Index spec", js: true do
	include UserSpecHelper
	
	before(:all) do
    FactoryBot.create(:state)
    FactoryBot.create(:district)
    FactoryBot.create(:lsg_body)
    FactoryBot.create(:ward)
    FactoryBot.create(:facility, kind: 'CHC')

    (1..5).each do
      FactoryBot.create(:patient)
    end

		(1..5).each do |i|
			category = "category_#{i}"
			(1..5).each do 
				FactoryBot.create(:treatment, category: category)
			end
		end
	end

	context 'When user sign in' do
		before do
			@user = FactoryBot.create(:user, verified: true)
			@patient = Patient.first
			@treatments = Treatment.limit(4).order("RANDOM()")
			@active_treatments = Treatment.where.not(id: @treatments.pluck(:id)).limit(4).order("RANDOM()")
			login_as(@user)
			visit patient_treatment_path(@patient)
		end

    scenario "Treatment Page" do      
			expect(page).to have_text("Treatments")
    end

		scenario "Add treatments to a patient" do

			#Select treatments from dropdowm
      within("#treatment-dropdown") do
				@treatments.each do |x|
					find("input[placeholder='Search']").click
					within("#dropdown-options") do
						click_button x.name
					end
				end
			end
			within("#selected-treatments") do
				@treatments.each do |x|
					expect(page).to have_text(x.name)
				end
			end

			#Add description
			within("#selected-treatments") do
				@treatments.each do |x|
					find("#textarea-#{x.id}").set(x.name)

				end
			end
		
			click_button "Add Treatment"

			#Check is treatments are added
			within("#active-treatments") do
				@treatments.each do |x|
					expect(page).to have_text(x.name)
				end
			end
		end
		scenario "Stop current treatments" do
			
		end
	end
end