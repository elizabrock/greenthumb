class AddCategoryToVarieties < ActiveRecord::Migration
  def change
    add_column :varieties, :category_id, :integer
  end
end
