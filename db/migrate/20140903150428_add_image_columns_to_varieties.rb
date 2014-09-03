class AddImageColumnsToVarieties < ActiveRecord::Migration
  def change
    add_column :varieties, :top_image, :string
    add_column :varieties, :side_image, :string
  end
end
