class AdminController < ApplicationController
  before_action :require_admin

  protected

  def require_admin
    return if current_user.admin?
    flash.alert = "You are not authorized to view that page."
    redirect_to :root
  end
end
