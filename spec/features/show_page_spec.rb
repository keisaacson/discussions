require 'spec_helper'

feature 'Participant Page' do
  background do
    @discussion = Discussion.create(:title => 'Test Discussion', :leader_email => 'test@test.com')
  end

  scenario 'Viewing the Participant Page' do
    visit discussions_path
    click_link 'Test Discussion'

    expect(current_path).to eq discussion_path(@discussion)
  end

  scenario 'Submitting a Question', :js => true do
    visit discussions_path
    click_link 'Test Discussion'

    click_on 'New Question'

    question = 'Test Question'
    
    find(:xpath, "//textarea[@id='question']").set question
    click_on 'Submit Question'
    
    expect(page).to have_content 'Question added successfully.'
  end
end