class CreateStuffedAnimalPurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :stuffed_animal_purchases do |t|
      t.belongs_to :stuffed_animal, index: true
      t.belongs_to :purchase_order, index: true
      t.timestamps
    end
  end
end
