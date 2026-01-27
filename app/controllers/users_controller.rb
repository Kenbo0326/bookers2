class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [ :edit, :update ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "successfully created user."
    else
      flash.now[:alert] = "error: failed to create user."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  @user = User.find(params[:id])
  if @user.update(user_params)
    redirect_to user_path(@user), notice: "User was successfully updated."
  else
    render :edit
  end
end

  def index
    @users = User.all
  end

  private

  def ensure_correct_user
    @user = User.find(params[:id])
    redirect_to user_path(Current.user) unless @user == Current.user
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :password, :password_confirmation)
  end
end
