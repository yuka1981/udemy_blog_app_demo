# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_article, only: %i[create]

  def create
    # personal solution, not good practice
    # @comment = Comment.build(comment_params)
    # @comment.user = current_user
    # @comment.article_id = params[:article_id]

    @comment = @article.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = 'A comment has been created.'
      # redirect_to article_path(@comment.article_id)
    else
      flash[:danger] = 'A comment has not been created.'
      # render
    end

    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_article
    @article = Article.find(params[:article_id])
  end
end
