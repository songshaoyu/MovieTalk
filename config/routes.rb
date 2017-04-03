Rails.application.routes.draw do
  devise_for :users
  resources :movies do
    member do
      post :favourite
      post :unfavourite
    end
    resources :reviews
  end
  root 'movies#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
