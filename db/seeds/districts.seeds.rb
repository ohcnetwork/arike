after 'development:states' do
  District.create!(
    name: 'Ernakulum',
    state_id: State.find_by(name: 'Kerela').id,
  )
end
