Rails.application.routes.draw do
  root "welcome#index"

  get "about", to: "welcome#about", as: :about

  devise_for :users

  namespace :admin do
    root "posts#index"

    resources :posts, except: :show
    resources :games, only: :index
    resources :subscriptions, only: :index
  end

  resources :games, only: %i[index show]
  resources :collections
  resources :collection_games, only: %i[create destroy]
  resources :subscriptions, only: :create
  resources :feedbacks, only: :create
end