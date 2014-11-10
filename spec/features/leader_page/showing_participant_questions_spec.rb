require 'spec_helper'

feature 'Updating Current Surveys' do
  background do
    @discussion = Discussion.create(:title => 'Test Discussion', :leader_email => 'test@test.com')
    @question = Question.create(:content => 'Test Question', :discussion_id => @discussion.id, :question_status => 'answered', :response => 'Test Response')
    @question2 = Question.create(:content => 'Another Question', :discussion_id => @discussion.id, :question_status => 'unanswered')
    visit "/discussions/#{@discussion.id}/leader"
    click_link 'Participant Q&A'
  end

  scenario 'Viewing Questions', :js => true do
    expect(page).to have_content 'Test Question'
    expect(page).to have_content 'Test Response'
    expect(page).to have_content 'Another Question'
    expect(page).to have_button('Respond', count: 1)
  end

  scenario 'Responding to a Question', :js => true do
    click_on 'Respond'

    find(:xpath, "//textarea[@name='question[response]']").set 'Another Response'
    click_on 'Save Response'

    expect(page).to have_content 'Another Question'
    expect(page).to have_content 'Another Response'
    expect(page).to_not have_button('Respond')   
  end

end