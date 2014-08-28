class GardensController < ApplicationController

  def create
    garden = Garden.create!
    flash.notice = "Your garden has been created!"
    redirect_to edit_garden_path(garden)
  end

 def edit
   @garden = Garden.find(params[:id]) # <--- This lets people load gardens that aren't theirs!! When we implement edit, we must fix this vulnerability!
end


def update
    garden = Garden.find(params[:id])
    if garden.update_attributes(garden_params)
      redirect_to edit_garden_path(garden)
    else
      render 'edit'
    end
 end

  private

    def garden_params
      params.require(:garden).permit(:name, :height, :width)
    end
end