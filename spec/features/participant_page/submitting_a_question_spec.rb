require 'spec_helper'

feature 'Submitting a Question' do
  background do
    @discussion = Discussion.create(:title => 'Test Discussion', :leader_email => 'test@test.com')
  end

  scenario 'Submitting a Question', :js => true do
    visit discussion_path(@discussion)
    
    click_on 'New Question'
    
    find(:xpath, "//textarea[@id='question']").set 'Test Question'
    click_on 'Submit Question'
    
    expect(page).to have_content 'Question added successfully.'
  end

end