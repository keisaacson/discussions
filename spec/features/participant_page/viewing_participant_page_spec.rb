require 'spec_helper'

feature 'Viewing Participant Page' do
  background do
    @discussion = Discussion.create(:title => 'Test Discussion', :leader_email => 'test@test.com')
  end

  scenario 'Default/Surveys View' do
    visit discussions_path
    click_link 'Test Discussion'

    expect(current_path).to eq discussion_path(@discussion)
    expect(page).to have_content 'There are currently no open surveys.'
  end

  scenario 'Questions & Answers View', :js => true do
    visit discussion_path(@discussion)
    click_on 'Questions & Answers'

    expect(page).to have_content 'The leader has not answered any questions yet.'
  end

  scenario 'New Question View', :js => true do
    visit discussion_path(@discussion)
    click_on 'New Question'

    expect(page).to have_content 'Ask the Discussion Leader a Question:'
    expect(page).to have_xpath("//textarea[@id='question']")
    expect(page).to have_selector("input[type=submit][value='Submit Question']")
  end

  scenario 'Return to Discussions Index' do
    visit discussion_path(@discussion)
    click_on 'All Discussions'

    expect(current_path).to eq discussions_path
    expect(page).to have_content 'Current Discussions'
  end
end