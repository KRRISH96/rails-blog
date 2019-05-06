class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def index
    @all_articles = Article.all
  end

  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was successfully saved!"
      redirect_to article_path(@article)
    else
      flash[:error] = "Article was not saved!"
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully!"
      redirect_to article_path(@article)
    else
      flash[:error] = "Article not updated!"
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Article was deleted!"
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end
end