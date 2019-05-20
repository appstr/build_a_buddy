Rails.application.routes.draw do
  root 'home#index'
  resources :stuffed_animals, only: [:index, :show]
  resources :accessories, only: [:index, :show]
end
