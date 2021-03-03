require 'rails_helper'

feature 'Index spec' do
  context 'When an user visits root path' do
    scenario 'Page will render correctly' do
      visit root_path

      expect(page).to have_text('Arike')
    end
  end
end
