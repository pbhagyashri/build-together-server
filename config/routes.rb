Rails.application.routes.draw do
  #devise_for :users
  
  namespace :api do
    resources :users, only: [:index, :show, :edit, :update, :destroy, :create]
    resources :users do
      resources :projects, only: [:index]
    end

    resources :projects do 
      resources :comments
    end

    resources :comments
    resources :sessions, only: [:create, :destroy]

    
  end


  #get '/api/users/:id/projects', to: 'users#user_projects'
end
