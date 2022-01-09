# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Delete an article' do
  before do
    user = User.create!(email: 'user@example.com', password: 'password')
    login_as(user)
    @article = Article.create(title: 'first article', body: 'article content', user: user)
  end

  scenario 'a user deletes an article' do
    visit '/'
    click_link @article.title
    click_link 'Delete'

    expect(page).to have_content('Article has been deleted')
    expect(page.current_path).to eq(articles_path)
  end
end
