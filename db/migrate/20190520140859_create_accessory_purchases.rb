class CreateAccessoryPurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :accessory_purchases do |t|
      t.belongs_to :accessory, index: true
      t.belongs_to :purchase_order, index: true
      t.timestamps
    end
  end
end
