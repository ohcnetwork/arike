require "rails_helper"

RSpec.describe "Facility", type: :request do
  before :each do
    @superuser = FactoryBot.create(:user, role: User.roles[:superuser], verified: true)
    post "/sessions", params: { user: { login_id: @superuser.email, password: @superuser.password } }
  end

  it "create a valid PHC"
  it "create a valid CHC"
  it "create a PHC without parent_id" do
    FactoryBot.create(:lsg_body)
    kind = "PHC"
    name = Faker::Name.name
    state = "Kerala"
    district = "District"
    lsg_body = LsgBody.first.id
    post facilities_path, params: { facility: { kind: kind, name: name, state: state, district: district, lsg_body: lsg_body } }
    expect(Facility.count).to eq(0)
  end
  it "create a CHC with parent_id"
  it "link a PHC to a CHC"
end
