class GardensController < ApplicationController
  before_filter :require_login

  def create
    garden = current_user.gardens.create!
    flash.notice = "Your garden has been created!"
    redirect_to edit_garden_path(garden)
  end

  def edit
    if @garden = current_user.gardens.find(params[:id])
    else
      flash.notice = "The garden could not be found."
      redirect_to gardens_path
    end
  end


  def update
    @garden = current_user.gardens.find(params[:id])
    if @garden.update_attributes(garden_params)
      flash.notice = "#{@garden.name} was successfully updated!"
      redirect_to gardens_path
    else
      flash.notice = "Your changes could not be saved."
      render 'edit'
    end
  end

  private

  def garden_params
    params.require(:garden).permit(:name, :height, :width)
  end
end
