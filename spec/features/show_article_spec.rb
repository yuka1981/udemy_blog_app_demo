# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Showing an article' do
  before do
    @reid = User.create(email: 'reid@example.com', password: 'password')
    @fred = User.create(email: 'fred@example.com', password: 'password')
    @article = Article.create(title: 'first article', body: 'article content.', user: @reid)
  end

  scenario 'hide edit and delete button with non-sign-in user' do
    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page.current_path).to eq(article_path(@article))
    expect(page).to have_link('Back')
    expect(page).not_to have_link('Edit')
    expect(page).not_to have_link('Delete')
  end

  scenario 'hide edit and delete button with non-owner' do
    login_as(@fred)

    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page.current_path).to eq(article_path(@article))
    expect(page).to have_link('Back')
    expect(page).not_to have_link('Edit')
    expect(page).not_to have_link('Delete')
  end

  # scenario 'show edit and delete button with article owner' do
  #   visit '/'
  #   click_link @article.title
  
  #   expect(page).to have_content(@article.title)
  #   expect(page).to have_content(@article.body)
  #   expect(page.current_path).to eq(article_path(@article))
  #   expect(page).to have_link('Back')
  # end
end
