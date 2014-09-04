class Admin::VarietiesController < AdminController
  before_action :load_category

  def new
    @variety = Variety.new
  end

  def create
    @variety = @category.varieties.build(variety_params)
    if @variety.save
      redirect_to admin_category_path(@category), notice: "The #{@variety.name} variety has been created."
    else
      flash.now[:alert] = "Variety could not be created."
      render :new
    end
  end

  def edit
    @variety = Variety.find(params[:id])
  end

  def update
    @variety = Variety.find(params[:id])
    if @variety.update(variety_params)
      redirect_to edit_admin_category_variety_path(@variety.category, @variety), notice: "The #{@variety.name} variety has been updated."
    else
      flash.now[:alert] = "Variety could not be updated."
      render :new
    end
  end

  def destroy
    Variety.find(params[:id]).destroy
    redirect_to admin_category_path(@category), notice: "Variety has been deleted."
  end

  protected

  def variety_params
    params.require(:variety).permit(:name, :description, :side_image, :top_image)
  end

  def load_category
    @category = Category.find(params[:category_id])
  end
end
