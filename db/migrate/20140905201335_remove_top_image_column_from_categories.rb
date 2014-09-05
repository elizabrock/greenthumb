class RemoveTopImageColumnFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :top_image, :string
  end
end
