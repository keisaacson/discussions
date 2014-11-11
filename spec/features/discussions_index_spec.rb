require 'spec_helper'

feature 'Discussions' do
  background do
    @discussion = Discussion.create(:title => 'Test Discussion', :leader_code => 'test')
    Discussion.create(:title => 'Another Discussion', :leader_code => 'test2')
  end

  scenario 'Viewing the Discussion Index' do
    visit discussions_path

    expect(page).to have_content 'Test Discussion'
    expect(page).to have_content 'Another Discussion'
  end

  scenario 'Creating a Discussion' do
    visit discussions_path

    title = 'Yet Another Test Discussion'
    leader_code = 'test'

    fill_in 'title', :with => title
    fill_in 'leader_code', :with => leader_code
    click_button 'Create Discussion'

    expect(page).to have_content title
  end
end