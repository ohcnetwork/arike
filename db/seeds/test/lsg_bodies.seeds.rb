after 'development:districts' do
  kinds = LsgBody.kinds.values
  (1..15).each do |index|
    LsgBody.create!(
      name: Faker::Name.name,
      kind: kinds.sample,
      code: Faker::Name.name,
      district_id: District.find_by(name: 'Ernakulam').id,
    )
  end
end
