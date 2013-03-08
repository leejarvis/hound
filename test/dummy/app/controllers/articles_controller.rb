class ArticlesController < ApplicationController

  def create
    @article = Article.create(params[:article])
    head :ok
  end

  def update
    @article = Article.find(params[:id])
    @article.update_attributes(params[:article])
    head :ok
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    head :ok
  end

end
