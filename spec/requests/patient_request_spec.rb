require "rails_helper"

RSpec.describe "Patients", type: :request do
  before :each do
    FactoryBot.create(:lsg_body)
    FactoryBot.create(:ward)
    @superuser = FactoryBot.create(:user, role: User.roles[:superuser], verified: true)
    post "/sessions", params: { user: { login_id: @superuser.email, password: @superuser.password } }
    Disease.create!(name: "DM", icds_code: "D-32")
    Disease.create!(name: "Hypertension", icds_code: "HT-58")

    kind = "CHC"
    name = Faker::Name.name
    state = "State"
    district = "District"
    pincode = Faker::Number.number(digits: 7)
    phone = Faker::Number.number(digits: 10)
    lsg_body_id = LsgBody.first.id
    ward_id = Ward.first.id
    post facilities_path, params: { facility: { kind: kind, name: name, state: state, district: district, lsg_body: lsg_body_id, ward: ward_id, phone: phone, pincode: pincode } }
    facility = Facility.last
    post "/patients", params: { patient: { full_name: "Test123", volunteer: {}, facility_id: facility.id } }
  end
  # it "renders the list of patients" do
  #   lsg_body = LsgBody.create!(name: "Test", kind: "Municipality")
  #   asha = User.create!(full_name: "Asha", role: User.roles[:asha], password: "01", email: "test@test.com")
  #   patient = Patient.create!(full_name: "Mogambe khush hua", lsg_body: lsg_body.id, asha_member: asha.id)
  #   get "/patients"
  #   expect(response).to render_template(:index)
  #   expect(response.body).to include(patient.full_name)
  # end

  it "adds a family member to the patient" do
    patient = Patient.last
    put "/patients/#{patient.id}/family_details", params: { patient_id: patient.id, familyDetails: { "1" => { full_name: Faker::Name.name, relation: "Brother" } } }
    family_members = patient.family_details
    expect(family_members.count).to eq(1)
  end

  it "adds a disease to patient" do
    patient = Patient.last
    put "/patients/#{patient.id}/patient_disease_summary", params: { patient_id: patient.id, patientDiseases: { "1" => { name: Disease.last.id } } }
    expect(PatientDiseaseSummary.count).to eq(1)
  end

  # it "assigns volunteers to the patient" do
  #   v1 = FactoryBot.create(:volunteer)
  #   v2 = FactoryBot.create(:volunteer)
  #   post "/patients", params: { patient: { full_name: "Test123", volunteer: { v1.id => 1, v2.id => 1 } } }
  #   patient = Patient.last
  #   expect(patient.users.volunteers).to include(v1, v2)
  # end

  # it "see single patient" do
  #   lsg_body = LsgBody.create!(name: "Test", kind: "Municipality")
  #   asha = User.create!(full_name: "Asha", role: User.roles[:asha], password: "01", email: "test@test.com")
  #   patient = Patient.create!(full_name: "Mogambe khush hua", lsg_body: lsg_body.id, asha_member: asha.id, reported_by: asha.id)
  #   get "/patients/#{patient.id}"
  #   expect(response).to render_template("patients/show")
  #   expect(response.body).to include(patient.full_name)
  # end
end
