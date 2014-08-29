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

  protected

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
