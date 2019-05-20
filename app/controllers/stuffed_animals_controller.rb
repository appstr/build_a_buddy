class StuffedAnimalsController < ApplicationController
  def index
    @stuffed_animals = StuffedAnimal.all
  end

  def show
    @stuffed_animal = StuffedAnimal.find(params[:id])
    @suggested_accessory ||= get_other_options(@stuffed_animal)
  end

  def get_other_options(stuffed_animal)
    accessory_ids = Hash.new(0)
    stuffed_animal.purchase_orders.each do |purchase|
      if !AccessoryPurchase.where(purchase_order_id: purchase.id).empty?
        accessory_ids[AccessoryPurchase.where(purchase_order_id: purchase.id).first.accessory_id] += 1
      end
    end
    accessory_id = accessory_ids.max_by{|k,v| v}[0]
    Accessory.find(accessory_id)
  end

end
