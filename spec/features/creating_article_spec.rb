# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Creating article' do
  scenario 'a user create a new article' do
    visit '/'
    click_link 'New Article'
    fill_in 'Title', with: 'New article'
    fill_in 'Body', with: 'Body content'
    click_button 'Create Article'

    expect(page).to have_content('Article has been created.')
    expect(page.current_path).to eq(articles_path)
  end
end
