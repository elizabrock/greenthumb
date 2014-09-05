class AddImageColumnsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :top_image, :string
    add_column :categories, :side_image, :string
  end
end
