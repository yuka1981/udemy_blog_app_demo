# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Delete an article' do
  before do
    @article = Article.create(title: 'first article', body: 'article content')
  end

  scenario 'a user deletes an article' do
    visit '/'
    click_link @article.title
    click_link 'Delete'

    expect(page).to have_content('Article has been deleted')
    expect(page.current_path).to eq(articles_path)
  end
end
