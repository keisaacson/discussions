require 'spec_helper'

feature 'Showing Survey Responses' do
  background do
    @discussion = Discussion.create(:title => 'Test Discussion', :leader_email => 'test@test.com')
    @survey = Survey.create(:survey_question => 'Test Survey', :discussion_id => @discussion.id, :survey_status => 'ended')
    @survey2 = Survey.create(:survey_question => 'Another Survey', :discussion_id => @discussion.id, :survey_status => 'ended')
    @response = SurveyResponse.create(:survey_id => @survey.id, :content => 'Test Response')
    @response2 = SurveyResponse.create(:survey_id => @survey.id, :content => 'Another Response')
    visit "/discussions/#{@discussion.id}/leader"
    click_link 'Ended Surveys'
  end

  scenario 'Viewing Ended Surveys', :js => true do
    expect(page).to have_content 'Test Survey'
    expect(page).to have_content 'Another Survey'
    expect(page).to have_button('View Responses', count: 2)
  end

  scenario 'Viewing Ended Survey Responses', :js => true do
    find_by_id("button-survey#{@survey.id}").click 

    expect(page).to have_content 'Survey Responses:'
    expect(page).to have_content @response.content
    expect(page).to have_content @response2.content
    expect(page).to have_button('Hide Responses')
  end

  scenario 'Viewing Ended Survey without Responses', :js => true do
    find_by_id("button-survey#{@survey2.id}").click 

    expect(page).to have_content 'Survey Responses:'
    expect(page).to have_content 'There were no responses to this survey.'
    expect(page).to have_button('Hide Responses')
  end

  scenario 'Hiding Survey Responses', :js => true do
    find_by_id("button-survey#{@survey.id}").click 
    click_on 'Hide Responses'

    expect(page).to_not have_content 'Survey Responses:'  
    expect(page).to_not have_content @response.content
    expect(page).to_not have_content @response2.content
    expect(page).to_not have_button('Hide Responses')  
  end

end