class AccessoriesController < ApplicationController
  def index
    @accessories = Accessory.all
    @sizes = ['small', 'medium', 'large']
  end

  def show
    @accessory = Accessory.find(params[:id])
  end
  
end
