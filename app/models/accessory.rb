class Accessory < ApplicationRecord
  has_many :compatibilities
  has_many :stuffed_animals, through: :compatibilities

  has_many :accessory_purchases
  has_many :purchase_orders, through: :accessory_purchases

  enum description: {shoes: 1, t_shirt: 2, tiara: 3, glasses: 4}
  enum size: {small: 1, medium: 2, large: 3, all_sizes: 4}
end
