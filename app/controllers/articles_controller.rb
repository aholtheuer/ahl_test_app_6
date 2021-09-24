class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
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
    @article.user = User.first
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
    #para acordarte de los path ocupas el comando en la terminal
    #rails routes --expanded y ves el prefijo de la ruta que quieres llegar
    redirect_to articles_path

  end

  private 
  
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

end

