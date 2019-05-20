class AccessoryPurchase < ApplicationRecord
  belongs_to :purchase_order
  belongs_to :accessory
end
