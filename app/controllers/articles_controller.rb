# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_article, only: %i[show edit update destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def show; end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      flash[:notice] = 'Article has been created.'
      redirect_to articles_path
    else
      flash.now[:danger] = 'Article has not been created.'
      render :new
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Article has been updated.'
      redirect_to @article
    else
      flash.now[:danger] = 'Article has not been updated.'
      render :edit
    end
  end

  def destroy
    return unless @article.destroy

    flash[:notice] = 'Article has been deleted.'
    redirect_to articles_path
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end

  # 覆寫 application 的 resource_not_found method
  def resource_not_found
    flash[:danger] = 'The article you are looking for could not be found.'
    redirect_to articles_path
  end
end
