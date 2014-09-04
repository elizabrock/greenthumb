class Admin::UsersController < AdminController
  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    user_params = params.require(:user).permit(:admin)
    @user.update_attributes!(user_params)
    redirect_to admin_users_path, notice: "Administration privileges of #{@user.email} have been updated."
  end
end
