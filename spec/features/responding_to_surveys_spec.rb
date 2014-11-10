require 'spec_helper'

feature 'Responding to Surveys' do
  background do
    @discussion = Discussion.create(:title => 'Test Discussion', :leader_email => 'test@test.com')
    @survey = Survey.create(:survey_question => 'Test Survey', :discussion_id => @discussion.id, :survey_status => 'open')
    @survey2 = Survey.create(:survey_question => 'Another Survey', :discussion_id => @discussion.id, :survey_status => 'closed')
  end

  scenario 'Showing Open Surveys' do
    visit discussion_path(@discussion)

    expect(page).to have_content 'Test Survey'
    expect(page).to_not have_content 'Another Survey'
  end

  scenario 'Responding to an Open Survey', :js => true do
    visit discussion_path(@discussion)

    screenshot_and_save_page

    find(:xpath, "//textarea[@id='survey#{@survey.id}-response']").set 'Test Response'
    click_on 'Submit Response'

    expect(page).to have_content 'Response submitted.'
  end
end