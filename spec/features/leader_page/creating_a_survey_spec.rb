require 'spec_helper'

feature 'Creating a Survey' do
  background do
    @discussion = Discussion.create(:title => 'Test Discussion', :leader_email => 'test@test.com')
    visit "/discussions/#{@discussion.id}/leader"
    click_link 'Create a Survey'
    @survey = 'Test Survey'
    find(:xpath, "//textarea[@id='question']").set @survey
  end

  scenario 'Creating a Survey for Later', :js => true do
    click_on 'Create Survey'

    expect(page).to have_content 'Survey created successfully.'

    click_link 'Current Surveys'

    expect(page).to have_content @survey
    expect(page).to have_content 'There are currently no open surveys.'
    expect(page).to_not have_content 'There are currently no surveys ready to be sent.'
    expect(page).to have_selector("input[type=submit][value='Send Survey']")
  end

  scenario 'Creating & Sending a Survey', :js => true do
    click_on 'Create & Send Survey'

    expect(page).to have_content 'Survey created and sent successfully.'

    click_link 'Current Surveys'

    expect(page).to have_content @survey
    expect(page).to have_content 'There are currently no surveys ready to be sent.'
    expect(page).to_not have_content 'There are currently no open surveys.'
    expect(page).to have_selector("input[type=submit][value='End Survey Now']")
    expect(page).to have_selector("input[type=button][value='Set Survey End Time']")
  end

end