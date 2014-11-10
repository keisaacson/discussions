require 'spec_helper'

feature 'Showing Questions & Answers' do
  background do
    @discussion = Discussion.create(:title => 'Test Discussion', :leader_email => 'test@test.com')
    @question = Question.create(:content => 'Test Question', :discussion_id => @discussion.id, :question_status => 'answered', :response => 'Test Response')
    @question2 = Question.create(:content => 'Another Question', :discussion_id => @discussion.id, :question_status => 'unanswered', :response => 'Another Response')
  end

  scenario 'Showing Answered Questions, not Unanswered Questions', :js => true do
    visit discussion_path(@discussion)
    
    click_on 'Questions & Answers'
    
    expect(page).to have_content 'Test Question'
    expect(page).to have_content 'Test Response'
    expect(page).to_not have_content 'Another Question'
    expect(page).to_not have_content 'Another Response'
  end

end