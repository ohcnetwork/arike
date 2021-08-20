require "rails_helper"

RSpec.describe "Patients", type: :request do
  before :each do
    FactoryBot.create(:state)
    FactoryBot.create(:district)
    FactoryBot.create(:lsg_body)
    FactoryBot.create(:ward)
    FactoryBot.create(:facility)

    Patient.create(full_name: Faker::Name.name, phone: rand(10**11), emergency_phone_no: rand(10**11), facility_id: Facility.last.id)
    Disease.create(name: "Corona")
    @superuser = FactoryBot.create(:user, role: User.roles[:superuser], verified: true)
    post user_session_path, params: { user: { login_id: @superuser.email, password: @superuser.password } }
  end

  it "renders the list of patients" do
    patient = Patient.create!(full_name: "Mogambe khush hua", phone: rand(10**11), emergency_phone_no: rand(10**11), facility_id: Facility.last.id)
    get "/patients"
    expect(response).to render_template(:index)
    expect(response.body).to include(patient.full_name)
  end

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

  it "assigns volunteers to the patient" do
    v1 = FactoryBot.create(:volunteer)
    v2 = FactoryBot.create(:volunteer)
    patient = Patient.last
    put "/patients/#{patient.id}", params: { patient: { full_name: "Test123", phone: rand(10**11), emergency_phone_no: rand(10**11), facility_id: Facility.last.id, volunteer: { v1.id => "on", v2.id => "on" } } }
    patient = Patient.last
    expect(patient.users.volunteers).to include(v1, v2)
  end

  it "see single patient" do
    patient = Patient.last
    get "/patients/#{patient.id}/show/personal_details"
    expect(response.body).to include(patient.full_name)
  end
end
