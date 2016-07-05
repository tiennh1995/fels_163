Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"

  resources :users, only: [:show, :index]
  namespace :admin do
    root "users#index"
    resources :users do
      collection do
        match "search" => "admin#users#index", via: [:get, :post], as: :search
      end
    end
  end
end
