Rails.application.routes.draw do
  #devise_for :users
  
  namespace :api do
    resources :users, only: [:index, :show, :edit, :update, :destroy, :create]
    resources :projects
    resources :comments
    resources :sessions, only: [:create, :destroy]
  end
end
