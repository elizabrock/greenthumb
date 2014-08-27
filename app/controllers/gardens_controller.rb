class GardensController < ApplicationController

  def create
    garden = Garden.create!
    flash.notice = "Your garden has been created!"
    redirect_to edit_garden_path(garden)
  end

  def edit
    @garden = Garden.find(params[:id]) # <--- This lets people load gardens that aren't theirs!! When we implement edit, we must fix this vulnerability!
  end
end
