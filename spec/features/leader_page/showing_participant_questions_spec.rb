require 'spec_helper'

feature 'Showing Participant Questions' do
  background do
    @discussion = Discussion.create(:title => 'Test Discussion', :leader_email => 'test@test.com')
    @question = Question.create(:content => 'Test Question', :discussion_id => @discussion.id, :question_status => 'answered', :response => 'Test Response')
    @question2 = Question.create(:content => 'Another Question', :discussion_id => @discussion.id, :question_status => 'unanswered')
    visit "/discussions/#{@discussion.id}/leader"
  end

  scenario 'Viewing Questions', :js => true do
    click_link 'New Questions'

    expect(page).to have_content 'Another Question'
    expect(page).to have_button('Respond', count: 1)

    click_link 'Answered Questions'

    expect(page).to have_content 'Test Question'
    expect(page).to have_content 'Test Response'
  end

  scenario 'Responding to a Question', :js => true do
    click_link 'New Questions'
    click_on 'Respond'

    find(:xpath, "//textarea[@name='question[response]']").set 'Another Response'
    click_on 'Save Response'

    expect(page).to_not have_button('Respond')   

    click_link 'Answered Questions'

    expect(page).to have_content 'Another Question'
    expect(page).to have_content 'Another Response'
  end

end