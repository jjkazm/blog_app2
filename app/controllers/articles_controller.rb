class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!, except: [:index, :show]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      flash.now[:danger] = "Article has not been created"
      render "new"
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article has been updated"
      redirect_to article_path(@article)
    else
      flash.now[:danger] = "Article has not been updated"
      render :edit
    end
  end

  def show
  end

  def destroy
    @article.destroy
    flash[:success] = "Article has been deleted"
    redirect_to articles_path
  end

  protected
    def resource_not_found
      flash[:alert] = "The article you are looking for can't be found"
      redirect_to root_path
    end

  private

    def article_params
      params.require(:article).permit(:title, :body)
    end

    def set_article
      @article = Article.find(params[:id])
    end

end
