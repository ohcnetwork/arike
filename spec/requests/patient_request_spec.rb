require 'rails_helper'

RSpec.describe "Patients", type: :request do
  it "renders the list of patients" do
    patient = Patient.create!(first_name: "Mogambe", full_name: "Mogambe khush hua")
    get "/patients"
    expect(response).to render_template(:index)
    expect(response.body).to include(patient.full_name)
  end

  it "creates a new patient with correct full name" do
    post "/patients", params: { patient: { full_name: "Test123", volunteer: {} } }
    expect(Patient.first.full_name).to eq("Test123")
  end

  it "assigns volunteers to the patient" do
    v1 = User.create!(first_name: "v1", role: "volunteer", password: "test123")
    v2 = User.create!(first_name: "v2", role: "volunteer", password: "test123")
    post "/patients", params: { patient: { full_name: "Test123", volunteer: { v1.id => 1, v2.id => 1 } } }
    patient = Patient.last
    expect(patient.users.volunteers).to include(v1, v2)
  end
end
