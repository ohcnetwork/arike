require 'rails_helper'
# Tests when logged in as superuser
RSpec.describe 'Facility as superuser', type: :request do
  before :each do
    FactoryBot.create(:lsg_body)
    FactoryBot.create(:ward)
    @superuser =
      FactoryBot.create(:user, role: User.roles[:superuser], verified: true)
    post '/sessions',
         params: {
           user: {
             login_id: @superuser.email,
             password: @superuser.password,
           },
         }
  end
  it 'accessing /facilities as super user' do
    get facilities_path
    expect(response.status).to eq(200)
  end
  it 'create a valid CHC' do
    kind = 'CHC'
    name = Faker::Name.name
    state_id = State.first
    district_id = District.first
    address = Faker::Address.full_address
    pincode = Faker::Number.number(digits: 7)
    phone = Faker::Number.number(digits: 10)
    lsg_body_id = LsgBody.first.id
    ward_id = Ward.first.id
    post facilities_path,
         params: {
           facility: {
             kind: kind,
             name: name,
             state_id: state_id,
             district_id: district_id,
             address: address,
             lsg_body_id: lsg_body_id,
             ward_id: ward_id,
             phone: phone,
             pincode: pincode,
           },
         }
    expect(Facility.count).to eq(1)
  end
  it 'create an invalid PHC (without parent_id)' do
    kind = 'PHC'
    name = Faker::Name.name
    state_id = State.first
    district_id = District.first
    address = Faker::Address.full_address
    pincode = Faker::Number.number(digits: 7)
    phone = Faker::Number.number(digits: 10)
    lsg_body_id = LsgBody.first.id
    post facilities_path,
         params: {
           facility: {
             kind: kind,
             name: name,
             state_id: state_id,
             district_id: district_id,
             address: address,
             lsg_body_id: lsg_body_id,
             phone: phone,
             pincode: pincode,
           },
         }
    expect(Facility.count).to eq(0)
  end
  it 'create an invalid CHC (with parent_id)' do
    FactoryBot.create(:facility, kind: 'CHC')
    current_count = Facility.count
    kind = 'CHC'
    name = Faker::Name.name
    state_id = State.first
    district_id = District.first
    address = Faker::Address.full_address
    lsg_body_id = LsgBody.first.id
    ward_id = Ward.first.id
    pincode = Faker::Number.number(digits: 7)
    phone = Faker::Number.number(digits: 10)
    parent_id = Facility.last.id
    post facilities_path,
         params: {
           facility: {
             kind: kind,
             name: name,
             state_id: state_id,
             district_id: district_id,
             address: address,
             lsg_body_id: lsg_body_id,
             ward_id: ward_id,
             parent_id: parent_id,
             phone: phone,
             pincode: pincode,
           },
         }
    expect(Facility.count).to eq(current_count)
  end
  it 'assigning a user to a facility' do
    FactoryBot.create(:user, role: User.roles[:secondary_nurse])
    FactoryBot.create(:facility, kind: Facility.kinds[:secondary])
    user_id = User.last.id
    facility_id = Facility.last.id
    put assign_facility_path,
        params: {
          facility: {
            facility_id: facility_id,
            user_id: user_id,
          },
        }
    expect(User.last.facility_id).to eq(facility_id)
  end
end

# Tests when not logged in
RSpec.describe 'Facility as normal user', type: :request do
  before :each do
    FactoryBot.create(:lsg_body)
    FactoryBot.create(:ward)
  end

  it 'accessing /facilities without perms' do
    get facilities_path
    expect(response.status).to eq(302)
    expect(response).to redirect_to(root_path)
  end

  it 'accessing /facilities/new without perms' do
    get new_facility_path
    expect(response.status).to eq(302)
    expect(response).to redirect_to(root_path)
  end
  it 'accessing /facilities/show/:id without perms' do
    FactoryBot.create(:facility, kind: 'CHC')
    get facility_path(Facility.last.id)
    expect(response.status).to eq(302)
    expect(response).to redirect_to(root_path)
  end

  it 'create a valid CHC without perms' do
    FactoryBot.create(:lsg_body)
    FactoryBot.create(:ward)
    kind = 'CHC'
    name = Faker::Name.name
    state_id = State.first
    district_id = District.first
    lsg_body_id = LsgBody.first.id
    ward_id = Ward.first.id
    post facilities_path,
         params: {
           facility: {
             kind: kind,
             name: name,
             state_id: state_id,
             district_id: district_id,
             lsg_body_id: lsg_body_id,
             ward_id: ward_id,
           },
         }
    expect(Facility.count).to eq(0)
  end

  it 'assigning a user to a facility' do
    FactoryBot.create(:user, role: User.roles[:secondary_nurse])
    FactoryBot.create(:facility, kind: Facility.kinds[:secondary])
    user_id = User.last.id
    facility_id = Facility.last.id
    put assign_facility_path,
        params: {
          facility: {
            facility_id: facility_id,
            user_id: user_id,
          },
        }
    expect(response).to redirect_to(root_path)
    expect(User.last.facility_id).to eq(nil)
  end
end
