class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :show, :destroy, :update]

  def new
    @article = Article.new
  end

  def index
    @all_articles = Article.all
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:notice] = "Article was successfully saved!"
      redirect_to article_path(@article)
    else
      flash[:error] = "Article was not saved!"
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully!"
      redirect_to article_path(@article)
    else
      flash[:error] = "Article not updated!"
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Article was deleted!"
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def set_article
      @article = Article.find(params[:id])
    end
end