# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'List artiles' do
  before do
    user = User.create!(email: 'user@example.com', password: 'password')
    @article1 = Article.create(title: 'first article', body: 'Lorem, ipsum dolor sit amet...', user: user)
    @article2 = Article.create(title: 'second article', body: 'Lorem, ipsum dolor sit amet consectetur...', user: user)
  end

  scenario 'a user lists all articles' do
    visit '/'

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end

  scenario 'a user has no article' do
    Article.delete_all

    visit '/'

    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)

    within('h2#no-articles') do
      expect(page).to have_content("No Articles Created.")
    end
  end
end
