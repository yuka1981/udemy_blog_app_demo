# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Articles", type: :request do
  before do
    @article = Article.create(title: 'first article', body: 'first article body')
  end

  describe 'GET /articles/:id' do
    context 'with existing article' do
      before { get "/articles/#{@article.id}" }

      it "handles existing article" do
        expect(response.success?).to eq(true)
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
