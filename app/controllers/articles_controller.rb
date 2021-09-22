class ArticlesController < ApplicationController
  def show
    #byebug
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
    #byebug
    @article = Article.find(params[:id])
  end

  def create
    #render plain: params[:article]
    @article = Article.new(params.require(:article).permit(:title, :description))
    #render plain: @article.inspect
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
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      render 'edit'
    end

  end

end

