require 'spec_helper'

feature 'Creating a Survey' do
  background do
    @discussion = Discussion.create(:title => 'Test Discussion', :leader_email => 'test@test.com')
  end

  scenario 'Creating a Survey for Later', :js => true do
    visit "/discussions/#{@discussion.id}/leader"
    click_link 'Create a Survey'

    survey = 'Test Survey'

    find(:xpath, "//textarea[@id='question']").set survey
    click_on 'Create Survey'

    expect(page).to have_content 'Survey created successfully.'

    click_link 'Current Surveys'

    expect(page).to have_content survey
    expect(page).to have_content 'There are currently no open surveys.'
    expect(page).to_not have_content 'There are currently no surveys ready to be sent.'
  end

  scenario 'Creating & Sending a Survey'

end