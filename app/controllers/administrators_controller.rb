class AdministratorsController < ApplicationController

  def update
    @user = User.find(params[:id])
    if @user.toggle(:admin)
      redirect_to users_path, notice: "administration privileges of #{@user.email} have been updated."
    else
      flash.now[:alert] = "Your changes could not be saved."
      render :edit
    end
  end

end
