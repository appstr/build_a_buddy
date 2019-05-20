class CreatePurchaseOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_orders do |t|
      t.datetime :purchase_datetime
      t.timestamps
    end
  end
end
