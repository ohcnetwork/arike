FactoryBot.define do
  factory :state, class: 'State' do
    name { Faker::Name.first_name }
  end
end
