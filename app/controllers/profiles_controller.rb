class ProfilesController < ApplicationController

  def edit
    @user = current_user
  end

  def update
    params[:password].blank? ? params.delete(:password) : ""
    current_user.update!(user_params)
    flash.now[:notice] = "Profile has been updated."
  end

protected

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
