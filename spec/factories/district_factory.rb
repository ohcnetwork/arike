FactoryBot.define do
  factory :district, class: 'District' do
    name { Faker::Name.first_name }
    state_id { State.last.id }
  end
end
