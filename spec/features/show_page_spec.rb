require 'spec_helper'

feature 'Participant Page' do
  background do
    @discussion = Discussion.create(:title => 'Test Discussion', :leader_email => 'test@test.com')
    Discussion.create(:title => 'Another Discussion', :leader_email => 'test2@test.com')
  end

  scenario 'Viewing the Participant Page' do
    visit discussions_path
    click_link 'Test Discussion'

    expect(current_path).to eq discussion_path(@discussion)
  end

  scenario 'Submitting a Question' do
    visit discussion_path(@discussion)

    question = 'Test Question'

    fill_in 'question', :with => question
    find(:xpath, "//input[@id='discussion_id']").set @discussion.id
    click_on 'Submit Question'
    click_on 'Leader Page'

    expect(page).to have_content question
  end
end