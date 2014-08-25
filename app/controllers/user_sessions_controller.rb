class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:user][:email], params[:user][:password])
      redirect_to root_path, notice: "Welcome back, #{@user.email}!"
    else
      @user = User.new(params.require(:user).permit(:email, :password))
      @user.valid?
      flash.now[:alert] = "We could not sign you in. Please check your sign in information below."
      render 'new'
    end
  end
end
