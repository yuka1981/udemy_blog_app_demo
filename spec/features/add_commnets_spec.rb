# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Adding reviews to articles' do
  before do
    @reid = User.create(email: 'reid@example.com', password: 'password')
    @fred = User.create(email: 'fred@example.com', password: 'password')
    @article = Article.create(title: 'first article', body: 'article content.', user: @reid)
  end

  scenario 'permits a signed in user to write a review' do
    login_as(@fred)

    visit '/'
    click_link @article.title
    fill_in 'New Comment', with: 'An amazing article'
    click_button 'New Comment'

    expect(page).to have_content('A comment has been created.') 
    expect(page).to have_content('An amazing article')
    expect(page.current_path).to eq(article_path(@article.id))
  end
end
