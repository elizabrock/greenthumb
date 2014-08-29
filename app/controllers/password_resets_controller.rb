class PasswordResetsController < ApplicationController
  skip_before_filter :require_login
  before_action :load_user, only: [:edit, :update]

  def new
    @user=User.new
  end

  def create
    @user = User.find_by_email(params[:user][:email])

    if @user
      if @user.deliver_reset_password_instructions!
        redirect_to(root_path, :notice => 'Instructions have been sent to your email.')
      else
        redirect_to(root_path, :alert => 'We could not send your password reset email.')
      end
    else
      redirect_to(root_path, :alert => "We could not send your password reset email.")
    end
  end

  def edit
  end

  def update
    is_password_confirmed = params[:user][:password_confirmation] == params[:user][:new_password]

    if is_password_confirmed
      if @user.change_password!(params[:user][:new_password])
        redirect_to(root_path, :notice => 'Password was successfully updated.')
      else
        flash[:alert] = "Could not reset password."
        render :action => "edit"
      end
    else
      flash[:alert] = "Passwords do not match."
      render :action => "edit"
    end
  end

  private

  def load_user
    if params
      @token = params.has_key?(:id) ? params[:id] : params[:user][:token]
      @user = User.load_from_reset_password_token(@token)
    end

    if @user.blank?
      not_authenticated
      return
    end
  end
end
