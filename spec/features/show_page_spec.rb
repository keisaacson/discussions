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

  xscenario 'Submitting a Question' do
    visit discussion_path(@discussion)
    click_on 'New Question'

    question = 'Test Question'

    find(:xpath, "//textarea[@id='question']").set question
    find(:xpath, "//input[@id='discussion_id']").set @discussion.id
    click_on 'Submit Question'
    click_on 'Leader Page'

    expect(page).to have_content question
  end
end