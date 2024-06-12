Rails.application.routes.draw do
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :favorites, only: [:index, :create]
      resources :learning_resources, only: [:index]
      resources :recipes, only: [:index]
      resources :sessions, only: [:create]
      resources :tourist_sites, only: [:index]
      resources :users, only: [:create]
    end
  end
end