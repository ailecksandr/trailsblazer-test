require 'test_helper'

class ThingIntegrationTest < Trailblazer::Test::Integration
  describe 'allows anonymous' do
    it 'create' do
      visit '/things/new'

      page.wont_have_css "form #thing_name[disabled]"
      click_button 'Create'
      page.must_have_css '.field_with_errors'
    end

    it 'update' do
      thing = Thing::Create.(thing: { name: 'Rails', description: 'Kickass web dev' }).model

      visit "/things/#{thing.id}/edit"
      page.must_have_css "form #thing_name[disabled]"
    end
  end
end