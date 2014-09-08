class CreateShapes < ActiveRecord::Migration
  def change
    create_table :shapes do |t|
      t.string :type
      t.string :color
      t.integer :top
      t.integer :left
      t.integer :width
      t.integer :height
      t.integer :garden_id

      t.timestamps
    end
    drop_table :circles
    drop_table :rectangles
  end
end
