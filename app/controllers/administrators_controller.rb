class AdministratorsController < ApplicationController
  before_filter :require_admin

  def update
    @user = User.find(params[:id])
    if @user.toggle(:admin)
      redirect_to users_path, notice: "administration privileges of #{@user.email} have been updated."
    else
      flash.now[:alert] = "Your changes could not be saved."
      render :edit
    end
  end

  protected

  def require_admin
    require_login
    redirect_to :root unless current_user.admin?
  end

end
