class GardensController < ApplicationController
  before_filter :require_login

  def index
    @gardens = current_user.gardens.all
  end

  def create
    garden = current_user.gardens.create!
    flash.notice = "Your garden has been created!"
    redirect_to edit_garden_path(garden)
  end

  def edit
    @garden = current_user.gardens.find_by_id(params[:id])
    if @garden.nil?
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

  def destroy
    garden = Garden.find(params[:id])
    garden.destroy!
    flash.notice = "Your garden has been deleted."
    redirect_to root_path
  end

  private

  def garden_params
    params.require(:garden).permit(:name, :height, :width)
  end
end
