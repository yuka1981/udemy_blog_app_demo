# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Articles", type: :request do
  before do
    @reid = User.create(email: 'reid@example.com', password: 'password')
    @fred = User.create(email: 'fred@example.com', password: 'password')
    @article = Article.create(title: 'first article', body: 'first article body', user: @reid)
  end

  # edit section
  describe 'GET /articles/:id/edit' do
    context 'with non-signed in user' do
      before { get "/articles/#{@article.id}/edit" }

      it 'redirects to the signin page' do
        expect(response).to have_http_status(:redirect)
        flash_message = 'You need to sign in or sign up before continuing.'
        # devise flash message key is 'alert'
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with signed in user who is not owner' do
      before do
        login_as(@fred)
        get "/articles/#{@article.id}/edit"
      end

      it 'redirect to the home page' do
        expect(response).to have_http_status(:redirect)
        flash_message = 'You can only edit your own article'
        expect(flash[:danger]).to eq(flash_message)
      end
    end

    context 'with signed in user as owner successful edit' do
      before do
        login_as(@reid)
        get "/articles/#{@article.id}/edit"
      end

      it 'edits article successfully' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  # delete section
  describe 'DELETE /articles/:id/destroy' do
    context 'with non-signed in user' do
      before { delete "/articles/#{@article.id}" }

      it 'redirects to the signin page' do
        expect(response).to have_http_status(:redirect)
        flash_message = 'You need to sign in or sign up before continuing.'
        # devise flash message key is 'alert'
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with signed in user who is not owner' do
      before do
        login_as(@fred)
        delete "/articles/#{@article.id}"
      end

      it 'redirect to the home page' do
        expect(response).to have_http_status(:redirect)
        flash_message = 'You can only delete your own article'
        expect(flash[:danger]).to eq(flash_message)
      end
    end

    context 'with signed in user as owner successful delete' do
      before do
        login_as(@reid)
        delete "/articles/#{@article.id}"
      end

      it 'delete article successfully' do
        expect(response).to have_http_status(:redirect)
        flash_message = 'Article has been deleted.'
        expect(flash[:notice]).to eq(flash_message)
      end
    end
  end

  describe 'GET /articles/:id' do
    context 'with existing article' do
      before { get "/articles/#{@article.id}" }

      it "handles existing article" do
        # deprecated in rails 6
        # expect(response.success?).to eq(true)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with non-existing article' do
      before { get "/articles/xxxx" }

      it "handles non-existing article" do
        flash_message = 'The article you are looking for could not be found.'

        expect(flash[:danger]).to eq(flash_message)
        expect(response).to redirect_to(articles_path)
      end
    end
  end
end
