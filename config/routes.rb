Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "sessions",
    omniauth_callbacks: "omniauth_callbacks"
  }
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"

  resources :words, only: :index
  resources :follows, only: [:create, :destroy]
  resources :categories, only: [:index, :show] do
    resources :lessons, only: [:show, :create, :update]
  end
  resources :users, except: :destroy do
    resources :activities, only: :index
    resources :lessons, only: [:index, :show]
  end
  resources :lessons, only: :index
  namespace :admin do
    root "users#index"
    resources :logs, only: :index
    resources :users do
      collection do
        match "search" => "admin#users#index", via: [:get, :post], as: :search
      end
    end
    resources :categories, except: [:edit, :update]
    resources :words
    resources :answers, only: :create
    resources :activities, only: :index
  end
end
