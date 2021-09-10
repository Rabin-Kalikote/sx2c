class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :find_article, only: [:show, :edit, :update, :destroy]

  def index
    params[:category] ? @category = params[:category] : @category = "latest"
    if @category == 'latest'
      @articles = Article.all.order("created_at DESC")
    else
      @articles = Article.where(:category=>@category).order("created_at DESC")
    end
  end

  def show
    @comments = Comment.where(:article_id=>@article).order("created_at DESC")
    @more_articles = Article.where(:category=>@article.category).where.not(:id=>@article.id).order("created_at DESC")
  end

  def search
    @query = params[:query]
    @articles = Article.where("title LIKE ?", "%#{@query}%")
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :category, :image, :bodypdf)
  end
end
