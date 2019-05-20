class PurchaseOrder < ApplicationRecord
  has_many :stuffed_animal_purchases
  has_many :stuffed_animals, through: :stuffed_animal_purchases

  has_many :accessory_purchases
  has_many :accessories, through: :accessory_purchases
end
