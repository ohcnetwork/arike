require "rails_helper"
# Tests when logged in as superuser
RSpec.describe "Facility as superuser", type: :request do
  before :each do
    FactoryBot.create(:lsg_body)
    FactoryBot.create(:ward)
    @superuser = FactoryBot.create(:user, role: User.roles[:superuser], verified: true)
    post "/sessions", params: { user: { login_id: @superuser.email, password: @superuser.password } }
  end
  it "accessing /facilities as super user" do
    get facilities_path
    expect(response.status).to eq(200)
  end
  it "create a valid CHC" do
    kind = "CHC"
    name = Faker::Name.name
    state = "State"
    district = "District"
    lsg_body_id = LsgBody.first.id
    ward_id = Ward.first.id
    post facilities_path, params: { facility: { kind: kind, name: name, state: state, district: district, lsg_body_id: lsg_body_id, ward_id: ward_id } }
    expect(Facility.count).to eq(1)
  end
  it "create an invalid PHC (without parent_id)" do
    kind = "PHC"
    name = Faker::Name.name
    state = "State"
    district = "District"
    lsg_body_id = LsgBody.first.id
    post facilities_path, params: { facility: { kind: kind, name: name, state: state, district: district, lsg_body_id: lsg_body_id } }
    expect(Facility.count).to eq(0)
  end
  it "create an invalid CHC (with parent_id)" do
    FactoryBot.create(:facility, kind: "CHC")
    current_count = Facility.count
    kind = "CHC"
    name = Faker::Name.name
    state = "State"
    district = "District"
    lsg_body_id = LsgBody.first.id
    ward_id = Ward.first.id
    parent_id = Facility.last.id
    post facilities_path, params: { facility: { kind: kind, name: name, state: state, district: district, lsg_body_id: lsg_body_id, ward_id: ward_id, parent_id: parent_id } }
    expect(Facility.count).to eq(current_count + 1)
  end
end
# Tests when not logged in
RSpec.describe "Facility as normal user", type: :request do
  before :each do
    FactoryBot.create(:lsg_body)
    FactoryBot.create(:ward)
  end
  it "accessing /facilities without perms" do
    get facilities_path
    expect(response.status).to eq(302)
    expect(response).to redirect_to(root_path)
  end
  it "accessing /facilities/new without perms" do
    get new_facility_path
    expect(response.status).to eq(302)
    expect(response).to redirect_to(root_path)
  end
  it "accessing /facilities/show/:id without perms" do
    FactoryBot.create(:facility, kind: "CHC")
    get facility_path(Facility.last.id)
    expect(response.status).to eq(302)
    expect(response).to redirect_to(root_path)
  end
  it "create a valid CHC without perms" do
    FactoryBot.create(:lsg_body)
    FactoryBot.create(:ward)
    kind = "CHC"
    name = Faker::Name.name
    state = "State"
    district = "District"
    lsg_body_id = LsgBody.first.id
    ward_id = Ward.first.id
    post facilities_path, params: { facility: { kind: kind, name: name, state: state, district: district, lsg_body_id: lsg_body_id, ward_id: ward_id } }
    expect(Facility.count).to eq(0)
  end
end
