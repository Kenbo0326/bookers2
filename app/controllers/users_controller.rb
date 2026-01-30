class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User was successfully created."
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "There was an error creating the user."
      render :new
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user && @user.update(user_params)
      flash[:notice] = "User was successfully updated."
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "There was an error updating the user."
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :introduction, :profile_image)
  end
end
