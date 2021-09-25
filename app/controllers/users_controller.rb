class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :requiere_user, only: [:edit, :update, :destroy]
  before_action :requiere_same_user, only: [:edit, :update, :destroy]


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

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated articles succesddfully deleted"
    redirect_to root_path
  end

  private 

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def requiere_same_user
    if (current_user != @user && !current_user.admin?)
      flash[:alert] = 'You can only edit your own profile'
      redirect_to user_path(current_user)
    end
  end

end
