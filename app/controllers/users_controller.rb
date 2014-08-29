class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      flash.notice = "Welcome to greenthumb, #{@user.email}!"
      redirect_to root_path
    else
      flash.now[:alert] = "Your account could not be created."
      render :new
    end
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: "administration privileges of #{@user.email} have been updated."
    else
      flash.now[:alert] = "Your changes could not be saved."
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :password, :admin)
  end
end
