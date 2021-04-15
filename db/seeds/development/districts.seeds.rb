require 'rest-client'
after 'development:states' do
  State.all.each_with_index do |state, index|
    response =
      RestClient.get "https://careapi.coronasafe.in/api/v1/state/#{index + 1}/districts/"
    districts = JSON.parse(response)
    districts.each do |district|
      District.create!(name: district['name'], state_id: state.id)
    end
  end
end
