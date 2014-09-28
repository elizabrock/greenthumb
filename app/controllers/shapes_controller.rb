class ShapesController < ApplicationController

  def create
    @garden = Garden.find(params[:garden_id])
    shape = @garden.shapes.build(shape_params)
    shape.save!

    respond_to do |format|
      format.json do
        render json: { message: "Your garden was saved!", id: shape.id }
      end
    end
  end

  def update
    @garden = Garden.find(params[:garden_id])
    shape = @garden.shapes.find(params[:id])
    shape.update_attributes(shape_params)
    shape.save!

    respond_to do |format|
      format.json { render json: { message: "Your garden was updated!" }}
    end
  end

  def destroy
    @garden = Garden.find(params[:garden_id])
    shape = @garden.shapes.find(params[:id])
    shape.destroy!

    respond_to do |format|
      format.json { render json: { message: "Your garden was updated!" }}
    end
  end

  protected

  def shape_params
    params.require(:shape).permit(:height, :width, :top, :left, :color, :type)
  end
end
