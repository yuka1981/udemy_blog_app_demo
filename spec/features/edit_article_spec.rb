# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Edit article' do
  before do
    @article = Article.create(title: 'first article', body: 'article content')
  end

  scenario 'a user updated an article' do
    visit '/'
    click_link @article.title
    click_link 'Edit'

    fill_in 'Title', with: 'Updated title'
    fill_in 'Body', with: 'Updated body content'
    click_button 'Update Article'

    expect(page).to have_content('Article has been updated')
    expect(page.current_path).to eq(article_path(@article))
  end

  scenario 'a user fails to updated an article' do
    visit '/'
    click_link @article.title
    click_link 'Edit'

    fill_in 'Title', with: ''
    fill_in 'Body', with: 'Updated body content'
    click_button 'Update Article'

    expect(page).to have_content('Article has not been updated')
    expect(page.current_path).to eq(article_path(@article))
  end
end
