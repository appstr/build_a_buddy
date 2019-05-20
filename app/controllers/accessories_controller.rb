class AccessoriesController < ApplicationController
  def index
    @accessories = Accessory.all
    @sizes = ['small', 'medium', 'large']
  end

  def show
    @accessory = Accessory.find(params[:id])
    @suggested_stuffed_animal ||= get_other_options(@accessory)
  end

  def get_other_options(accessory)
    stuffed_animal_ids = Hash.new(0)
    accessory.purchase_orders.each do |purchase|
      if !StuffedAnimalPurchase.where(purchase_order_id: purchase.id).empty?
        stuffed_animal_ids[StuffedAnimalPurchase.where(purchase_order_id: purchase.id).first.stuffed_animal_id] += 1
      end
    end
    stuffed_animal_id = stuffed_animal_ids.max_by{|k,v| v}[0]
    StuffedAnimal.find(stuffed_animal_id)
  end
end
