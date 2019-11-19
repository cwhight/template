Rails.application.routes.draw do
  devise_for :users
  root to: 'jobs#index'
  resources :jobs do
    resources :shifts do
      resources :requests, except: [:show]
    end
  end

  get '/dashboard', to: 'pages#dashboard'

  resources :requests, only: [:show]
  resources :users, only: [:edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
