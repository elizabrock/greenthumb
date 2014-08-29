class AdministratorsController < ApplicationController

  def index
    @administrators = User.all
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
    params.require(:user).permit(:admin, :id)
  end

end
