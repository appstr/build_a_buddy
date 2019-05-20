class StuffedAnimal < ApplicationRecord
  has_many :compatibilities
  has_many :accessories, through: :compatibilities

  has_many :stuffed_animal_purchases
  has_many :purchase_orders, through: :stuffed_animal_purchases

  enum description: {bear: 1, elephant: 2, tiger: 3, gorilla: 4}
end
