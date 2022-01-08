# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Creating article' do
  before do
    @user = User.create!(email: 'user@example.com', password: 'password')
    login_as(@user)
  end

  scenario 'a user create a new article' do
    visit '/'
    click_link 'New Article'
    fill_in 'Title', with: 'New article'
    fill_in 'Body', with: 'Body content'
    click_button 'Create Article'

    expect(page).to have_content('Article has been created.')
    expect(page.current_path).to eq(articles_path)
  end

  scenario 'a user create a new article without title' do
    visit '/'
    click_link 'New Article'
    fill_in 'Title', with: ''
    fill_in 'Body', with: 'Body content'
    click_button 'Create Article'

    expect(page).to have_content('Article has not been created.')
    expect(page).to have_content("Title can't be blank")
  end

  scenario 'a user create a new article without content body' do
    visit '/'
    click_link 'New Article'
    fill_in 'Title', with: 'New article'
    fill_in 'Body', with: ''
    click_button 'Create Article'

    expect(page).to have_content('Article has not been created.')
    expect(page).to have_content("Body can't be blank")
  end

  scenario 'a user create a new article with empty title and content body' do
    visit '/'
    click_link 'New Article'
    fill_in 'Title', with: ''
    fill_in 'Body', with: ''
    click_button 'Create Article'

    expect(page).to have_content('Article has not been created.')
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end
