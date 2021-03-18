require 'rails_helper'

RSpec.describe "Patients", type: :request do
  it "renders the list of patients" do
    patient = Patient.create!(first_name: "Mogambe", full_name: "Mogambe khush hua")
    get "/patients"
    expect(response).to render_template(:index)
    expect(response.body).to include(patient.full_name)
  end
end
