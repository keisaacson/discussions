require 'spec_helper'

feature 'Leader Page' do
  background do
    @discussion = Discussion.create(:title => 'Test Discussion', :leader_email => 'test@test.com')
  end

  scenario 'Creating a Closed Survey', :js => true do
    visit "/discussions/#{@discussion.id}/leader"
    click_on 'Create a Survey'

    survey = 'Test Survey'

    fill_in 'question', :with => survey
    click_on 'Create Survey'

    expect(page).to have_content 'Survey created successfully.'
    # expect(page).to have_selector("input[type=submit][value='Send Survey']")
  end

  scenario 'Sending a Closed Survey', :js => true do
    visit "/discussions/#{@discussion.id}/leader"
    click_on 'Create a Survey'

    survey = 'Test Survey'

    fill_in 'question', :with => survey
    click_on 'Create Survey'

    click_on 'Current Surveys'
    click_on 'Send Survey'

    expect(page).to have_content survey
    expect(page).to have_selector("input[type=submit][value='End Survey Now']")
  end

  scenario 'Creating and Sending a Survey', :js => true do
    visit "/discussions/#{@discussion.id}/leader"
    click_on 'Create a Survey'

    survey = 'Test Survey'

    fill_in 'question', :with => survey
    click_on 'Create & Send Survey'

    click_on 'Current Surveys'

    expect(page).to have_content survey
    expect(page).to have_selector("input[type=submit][value='End Survey Now']")
  end

  scenario 'Ending a Survey Now', :js => true do
    visit "/discussions/#{@discussion.id}/leader"
    click_on 'Create a Survey'

    survey = 'Test Survey'

    fill_in 'question', :with => survey
    click_on 'Create & Send Survey'

    click_on 'Current Surveys'
    click_on 'End Survey Now'

    click_on 'Ended Surveys'

    expect(page).to have_content survey
    expect(page).to have_button("View Responses")
  end

end



