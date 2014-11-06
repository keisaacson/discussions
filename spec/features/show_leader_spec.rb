require 'spec_helper'

feature 'Leader Page' do
  background do
    @discussion = Discussion.create(:title => 'Test Discussion', :leader_email => 'test@test.com')
  end

  scenario 'Viewing the Leader Page' do
    visit discussions_path
    click_link 'Test Discussion'
    click_link 'Leader Page'

    expect(current_path).to eq "/discussions/#{@discussion.id}/leader"
  end

  scenario 'Creating a Closed Survey' do
    visit "/discussions/#{@discussion.id}/leader"

    survey = 'Test Survey'

    fill_in 'question', :with => survey
    find(:xpath, "//input[@name='survey[discussion_id]']").set @discussion.id
    click_on 'Create Survey'

    expect(page).to have_content survey
  end
end