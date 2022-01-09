# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Showing an article' do
  before do
    user = User.create!(email: 'user@example.com', password: 'password')
    @article = Article.create(title: 'first article', body: 'article content.', user: user)
  end

  scenario 'a user shows an article' do
    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page.current_path).to eq(article_path(@article))
    expect(page).to have_link('Back')
  end
end
