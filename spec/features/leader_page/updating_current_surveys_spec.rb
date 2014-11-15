require 'spec_helper'

feature 'Updating Current Surveys' do
  background do
    @discussion = Discussion.create(:title => 'Test Discussion', :leader_code => 'test')
    @survey = Survey.create(:survey_question => 'Test Survey', :discussion_id => @discussion.id, :survey_status => 'open')
    @survey2 = Survey.create(:survey_question => 'Another Survey', :discussion_id => @discussion.id, :survey_status => 'closed')
    visit discussion_path(@discussion)
    click_link 'Leader View'
    find(:xpath, "//input[@name='leader_code']").set 'test'
    click_on 'Submit'
  end

  scenario 'Viewing Open/Closed Surveys' do
    expect(page).to have_content 'Test Survey'
    expect(page).to have_content 'Another Survey'
    expect(page).to_not have_content 'There are currently no open surveys.'
    expect(page).to_not have_content 'There are currently no surveys ready to be sent.'
  end

  scenario 'Sending a Closed Survey', :js => true do
    click_on 'Send Survey'

    expect(page).to have_content 'Another Survey'
    expect(page).to have_content 'There are currently no surveys ready to be sent.'
    expect(page).to have_selector("input[type=submit][value='End Survey Now']", count: 2)
    expect(page).to have_selector("input[type=button][value='Set Survey End Time']", count: 2)
  end

  scenario 'Ending an Open Survey Now', :js => true do
    click_on 'End Survey Now'

    expect(page).to_not have_content 'Test Survey'
    expect(page).to have_content 'There are currently no open surveys.'

    click_on 'Ended Surveys'

    expect(page).to have_content 'Test Survey'
    expect(page).to have_button('View Responses')
  end

  xscenario 'Setting Survey End Time', :js => true do
    click_on 'Set Survey End Time'

    find(:xpath, "//input[@name='seconds']").set 2
    click_on 'Set Survey End Time'

    expect(page).to have_content 'Test Survey'
    sleep 2
    expect(page).to have_content 'until survey closes'

    expect(page).to_not have_content 'Test Survey'
    expect(page).to have_content 'There are currently no open surveys.'

    click_on 'Ended Surveys'

    expect(page).to have_content 'Test Survey'
    expect(page).to have_button('View Responses')
  end
end