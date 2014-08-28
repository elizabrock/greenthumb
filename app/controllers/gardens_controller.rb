class GardensController < ApplicationController

  def create
    garden = current_user.gardens.create!
    flash.notice = "Your garden has been created!"
    redirect_to edit_garden_path(garden)
  end

 def edit
  if @garden = current_user.gardens.find_by_id(params[:id]) # <--- This lets people load gardens that aren't theirs!! When we implement edit, we must fix this vulnerability!
    @garden
  else
    redirect_to gardens_path
  end
end


def update
    @garden = Garden.find(params[:id])
    if @garden.update_attributes(garden_params)
      flash.notice = "#{@garden.name} was successfully updated!"
      redirect_to gardens_path
    else
      render 'edit'
    end
 end

  private

    def garden_params
      params.require(:garden).permit(:name, :height, :width)
    end
end
