class StuffedAnimalsController < ApplicationController
  def index
    @stuffed_animals = StuffedAnimal.all
  end

  def show
    @stuffed_animal = StuffedAnimal.find(params[:id])
  end

end
