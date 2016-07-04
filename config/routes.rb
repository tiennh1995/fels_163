Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"

  namespace :admin do
    root "users#index"
  end
end
