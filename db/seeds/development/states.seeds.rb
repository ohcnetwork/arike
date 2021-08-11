require 'rest-client'
response = RestClient.get 'https://careapi.coronasafe.in/api/v1/state/'
states = JSON.parse(response)['results']
states.each { |state| State.create!(name: state['name']) }
