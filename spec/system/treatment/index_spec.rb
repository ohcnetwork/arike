require "rails_helper"

feature "Index spec", js: true do
	include UserSpecHelper
	
	before(:all) do
    FactoryBot.create(:state)
    FactoryBot.create(:district)
    FactoryBot.create(:lsg_body)
    FactoryBot.create(:ward)
    FactoryBot.create(:facility, kind: 'CHC')
    @patient = FactoryBot.create(:patient)

		(1..5).each do |i|
			category = "category_#{i}"
			(1..5).each do 
				FactoryBot.create(:treatment, category: category)
			end
		end
		
		@active_treatments = Treatment.limit(4).order("RANDOM()")
		@active_treatments.each do |x|
			PatientTreatment.create(name: x.name, category: x.category, patient_id: @patient.id)
		end
	end

	context 'When user sign in' do
		before do
			@user = FactoryBot.create(:user, verified: true)
			login_as(@user)
			visit patient_treatment_path(@patient)
		end

    scenario "Treatment Page" do      
			expect(page).to have_text("Treatments")
    end

		scenario "Add treatments to a patient" do
			treatments = Treatment.where.not(id: @active_treatments.pluck(:id)).limit(4).order("RANDOM()")

			#Select treatments from dropdowm
      within("#treatment-dropdown") do
				treatments.each do |x|
					find("input[placeholder='Search']").click
					within("#dropdown-options") do
						click_button x.name
					end
				end
			end

			within("#selected-treatments") do
				treatments.each do |x|
					expect(page).to have_text(x.name)
				end
			end

			#Add description
			within("#selected-treatments") do
				treatments.each do |x|
					find("#textarea-#{x.id}").set(Faker::Lorem.paragraph)
				end
			end
			
			#Remove last treatment
			within("#selected-#{treatments.last.id}") do
				click_button 'Remove'
			end
		
			click_button "Add Treatment"

			#Check is treatments are added
			within("#active-treatments") do
				puts treatments.pluck(:name)
				puts treatments.limit(3).pluck(:name)
				treatments.each_with_index do |x, i|
					treatments.last == x ? (expect(page).not_to have_text(x.name)) : (expect(page).to have_text(x.name))
				end
			end
		end

		scenario "Stop current treatments" do

			#Stop any 2 treatments
			treatment = PatientTreatment.limit(2).order("RANDOM()")
			within("#active-treatments") do
				treatment.each do |x|
					expect(page).to have_text(x.name)
					find("button[value='#{x.id}']").click
					expect(page).not_to have_text(x.name)
				end
			end
		end
	end
end