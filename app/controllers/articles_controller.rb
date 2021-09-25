class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :requiere_user, except: [:show, :index]
  before_action :requiere_same_user, only: [:update, :edit, :destroy]
  
  def show
    #byebug
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit
    #byebug
  end

  def create
    #render plain: params[:article]
    @article = Article.new(article_params)
    @article.user = current_user
    # render plain: @article.inspect
    if @article.save
    #redirect_to article_path(@article)
      flash[:notice] = "Article was created successfully"
      redirect_to @article
    else
      render 'articles/new'
    end

  end


  def update
    #byebug
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      render 'edit'
    end

  end

  def destroy 
    @article.destroy
    redirect_to articles_path
  end

  private 
  
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def requiere_same_user 
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @article
    end
  end
end

