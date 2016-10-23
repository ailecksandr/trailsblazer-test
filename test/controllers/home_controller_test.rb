require 'test_helper'

class IntegrationTest < Trailblazer::Test::Integration
  it do
    Thing::Create.(thing: { name: 'Trailblazer' })
    Thing::Create.(thing: { name: 'Descendents' })

    visit '/'

    page.must_have_link 'Descendents'
    link = page.find '.columns.end .header a'
    link.text.must_equal 'Trailblazer'
  end
end