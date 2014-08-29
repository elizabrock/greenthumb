class PasswordResetsController < ApplicationController
  skip_before_filter :require_login

  def index
    @user=User.new
  end

  # request password reset.
  # you get here when the user entered his email in the reset password form and submitted it.
  def create
    @user = User.find_by_email(params[:user][:email])
    # binding.pry

    # This line sends an email to the user with instructions on how to reset their password (a url with a random token)
    if @user
      if @user.deliver_reset_password_instructions!
        redirect_to(root_path, :notice => 'Instructions have been sent to your email.')
      else
        redirect_to(root_path, :alert => 'Email was not successfully sent.')
      end
    else
      redirect_to(root_path, :alert => "Couldn't find user.")
    end
    # Tell the user instructions have been sent whether or not email was found.
    # This is to not leak information to attackers about which emails exist in the system.
    
  end

  # This is the reset password form.
  def edit
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]

    if @user.blank?
      not_authenticated
      return
    end
  end

  # This action fires when the user has sent the reset password form.
  def update
    @token = params[:user][:token]
    @user = User.load_from_reset_password_token(@token)

    if @user.blank?
      not_authenticated
      return
    end

    # the next line makes the password confirmation validation work
    # @user.password_confirmation = params[:user][:password_confirmation]
    is_password_confirmed = params[:user][:password_confirmation] == params[:user][:new_password]
    # the next line clears the temporary token and updates the password
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
end
