require 'spec_helper'

feature 'html requests' do
  scenario 'the root url should show something' do
    visit '/'

    page.should have_content 'Shared Cinema'
  end
end
