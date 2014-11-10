require 'spec_helper'

feature 'Viewing Leader Page' do
  background do
    @discussion = Discussion.create(:title => 'Test Discussion', :leader_email => 'test@test.com')
  end

  scenario 'Default/Current Surveys View' do
    visit discussions_path
    click_link 'Test Discussion'
    click_link 'Leader View'

    expect(current_path).to eq "/discussions/#{@discussion.id}/leader"
    expect(page).to have_content 'There are currently no open surveys.'
    expect(page).to have_content 'There are currently no closed surveys.'
  end

end