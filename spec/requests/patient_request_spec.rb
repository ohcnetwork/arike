require "rails_helper"

RSpec.describe "Patients", type: :request do
  it "renders the list of patients" do
    lsg_body = LsgBody.create!(name: "Test", kind: "Municipality")
    asha = User.create!(full_name: "Asha", role: "asha", password: "01", email: "test@test.com")
    patient = Patient.create!(full_name: "Mogambe khush hua", lsg_body: lsg_body.id, asha_member: asha.id)
    get "/patients"
    expect(response).to render_template(:index)
    expect(response.body).to include(patient.full_name)
  end

  it "creates a new patient with correct full name" do
    post "/patients", params: { patient: { full_name: "Test123", volunteer: {} } }
    expect(Patient.first.full_name).to eq("Test123")
  end

  it "assigns volunteers to the patient" do
    v1 = FactoryBot.create(:volunteer)
    v2 = FactoryBot.create(:volunteer)
    post "/patients", params: { patient: { full_name: "Test123", volunteer: { v1.id => 1, v2.id => 1 } } }
    patient = Patient.last
    expect(patient.users.volunteers).to include(v1, v2)
  end

  it "see single patient" do
    lsg_body = LsgBody.create!(name: "Test", kind: "Municipality")
    asha = User.create!(full_name: "Asha", role: "asha", password: "01", email: "test@test.com")
    patient = Patient.create!(full_name: "Mogambe khush hua", lsg_body: lsg_body.id, asha_member: asha.id, reported_by: asha.id)
    get "/patients/#{patient.id}"
    expect(response).to render_template("patients/show")
    expect(response.body).to include(patient.full_name)
  end
end
