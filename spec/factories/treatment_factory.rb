FactoryBot.define do
    factory :treatment, class: "Treatment" do
      category { Faker::Name.first_name }
      name { Faker::Name.first_name }
    end
  end