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
    expect(page).to have_selector("input[type=submit][value='Send Survey']")
  end

  scenario 'Sending a Closed Survey' do
    visit "/discussions/#{@discussion.id}/leader"

    survey = 'Test Survey'

    fill_in 'question', :with => survey
    find(:xpath, "//input[@name='survey[discussion_id]']").set @discussion.id
    click_on 'Create Survey'
    click_on 'Send Survey'

    expect(page).to have_content survey
    expect(page).to have_selector("input[type=submit][value='End Survey Now']")
  end

  scenario 'Creating and Sending a Survey' do
    visit "/discussions/#{@discussion.id}/leader"

    survey = 'Test Survey'

    fill_in 'question', :with => survey
    find(:xpath, "//input[@name='survey[discussion_id]']").set @discussion.id
    click_on 'Create & Send Survey'

    expect(page).to have_content survey
    expect(page).to have_selector("input[type=submit][value='End Survey Now']")
  end

  scenario 'Ending a Survey Now' do
    visit "/discussions/#{@discussion.id}/leader"

    survey = 'Test Survey'

    fill_in 'question', :with => survey
    find(:xpath, "//input[@name='survey[discussion_id]']").set @discussion.id
    click_on 'Create & Send Survey'
    click_on 'End Survey Now'

    expect(page).to have_content survey
    expect(page).to have_button("View Responses")
  end

  xscenario 'Setting a Survey End Time' do
    visit "/discussions/#{@discussion.id}/leader"

    survey = 'Test Survey'
    seconds = 3

    fill_in 'question', :with => survey
    find(:xpath, "//input[@name='survey[discussion_id]']").set @discussion.id
    click_on 'Create & Send Survey'
    click_on 'Set Survey End Time'
    
  end
end



