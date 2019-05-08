class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :show, :destroy, :update]

  def new
    @article = Article.new
  end

  def index
    @all_articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:success] = "Article was successfully saved!"
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
    @article.user = User.last
    if @article.update(article_params)
      flash[:success] = "Article was updated successfully!"
      redirect_to article_path(@article)
    else
      flash[:error] = "Article not updated!"
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:success] = "Article was deleted!"
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