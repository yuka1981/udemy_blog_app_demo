# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comment', type: :request do
  before do
    @reid = User.create(email: 'reid@example.com', password: 'password')
    @fred = User.create(email: 'fred@example.com', password: 'password')
    @article = Article.create(title: 'first article', body: 'first article body', user: @reid)
  end

  describe 'POST /articles/:id/comments' do
    context 'with a non signin-in user' do
      before do
        post "/articles/#{@article.id}/comments", params: { comment: { body: 'Awesome blog' } }
      end

      it 'redirect user to the signin page' do
        flash_message = 'Please sign in or sing up first'
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(:redirect)
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with a logged in user' do
      before do
        login_as(@fred)
        post "/articles/#{@article.id}/comments", params: { comment: { body: 'Awesome blog' } }
      end

      it 'redirect user to the signin page' do
        flash_message = 'A comment has been created.'
        expect(response).to redirect_to(article_path(@article))
        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]).to eq(flash_message)
      end
    end
  end
end
