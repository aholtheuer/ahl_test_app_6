class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  def new
    @user = User.new
  end

  def show
    #@user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the blog #{@user.username} chupapija!"
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have edited your user data!"
      redirect_to articles_path
    else
      render "edit"
    end
  end

  private 

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
