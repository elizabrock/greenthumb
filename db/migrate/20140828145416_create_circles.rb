class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.string :color
      t.integer :width
      t.integer :height
      t.integer :top
      t.integer :left
      t.integer :garden_id

      t.timestamps
    end
  end
end
