class GardensController < ApplicationController

  def index
    @gardens = Garden.all
  end

  def create
    garden = current_user.gardens.create!
    flash.notice = "Your garden has been created!"
    redirect_to edit_garden_path(garden)
  end

  def edit
    @garden = Garden.find(params[:id]) # <--- This lets people load gardens that aren't theirs!! When we implement edit, we must fix this vulnerability!
  end

  def destroy
    garden = Garden.find(params[:id])
    garden.destroy!
    flash.notice = "Your garden has been deleted."
    redirect_to root_path
  end
end
