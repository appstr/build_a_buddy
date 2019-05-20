class CreateStuffedAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :stuffed_animals do |t|
      t.integer :description
      t.integer :quantity
      t.float :cost
      t.float :sale_price
      t.float :profit
      t.string :product_image
      t.timestamps
    end
  end
end
