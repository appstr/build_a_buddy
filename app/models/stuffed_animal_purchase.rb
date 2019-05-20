class StuffedAnimalPurchase < ApplicationRecord
  belongs_to :purchase_order
  belongs_to :stuffed_animal
end
