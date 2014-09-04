class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def index
    @users = User.all
  end

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

  def edit
    @user = current_user
  end

  def update
    if params[:password].blank?
      params.delete(:password)
    end
    if current_user.update!(user_params)
      flash.notice = "Profile has been updated."
      redirect_to :action => :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
