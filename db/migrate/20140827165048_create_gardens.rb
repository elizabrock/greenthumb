class CreateGardens < ActiveRecord::Migration
  def change
    create_table :gardens do |t|
      t.string :name
      t.integer :height
      t.integer :width
      t.integer :user_id

      t.timestamps
    end
  end
end
