Rails.application.routes.draw do
  devise_for :users, class_name: "FormUser", controllers: {
    registrations: "users/registrations",
    sessions: "sessions",
    omniauth_callbacks: "omniauth_callbacks"
  }
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"

  resources :users
  namespace :admin do
    root "users#index"
    resources :logs, only: :index
    resources :users do
      collection do
        match "search" => "admin#users#index", via: [:get, :post], as: :search
      end
    end
    resources :categories, except: [:destroy, :edit, :update]
    resources :words
    resources :answers, only: :create
  end
end
