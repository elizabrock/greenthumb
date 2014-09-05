class Api::VarietiesController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    respond_to do |format|
      format.html { render html: api_category_varieties_path(@category) }
    end
  end
end
