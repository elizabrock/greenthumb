class VarietiesController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    respond_to do |format|
      format.json { render json: @category.varieties }
    end
  end
end
