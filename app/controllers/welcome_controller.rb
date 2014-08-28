class WelcomeController < ApplicationController
  def index
    if logged_in?
      redirect_to gardens_path
    end
  end
end
