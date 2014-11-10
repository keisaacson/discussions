require 'spec_helper'

feature 'Viewing Leader Page' do
  background do
    @discussion = Discussion.create(:title => 'Test Discussion', :leader_email => 'test@test.com')
  end

  scenario 'Default/Current Surveys View', :js => true do
    visit discussions_path
    click_link 'Test Discussion'
    click_link 'Leader View'

    expect(current_path).to eq "/discussions/#{@discussion.id}/leader"
    expect(page).to have_content 'There are currently no open surveys.'
    expect(page).to have_content 'There are currently no surveys ready to be sent.'
  end

  scenario 'Create a Survey View', :js => true do
    visit "/discussions/#{@discussion.id}/leader"
    click_link 'Create a Survey'

    expect(page).to have_content 'Create a New Survey Question:'
    expect(page).to have_xpath("//textarea[@id='question']")
    expect(page).to have_selector("input[type=submit][value='Create Survey']")
    expect(page).to have_selector("input[type=submit][value='Create & Send Survey']")
  end

  scenario 'Ended Surveys View', :js => true do
    visit "/discussions/#{@discussion.id}/leader"
    click_link 'Ended Surveys'

    expect(page).to have_content 'Ended Surveys'
    expect(page).to have_content 'There are currently no ended surveys.'
  end

  scenario 'Participant Q&A View'

end