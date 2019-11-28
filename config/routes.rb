Rails.application.routes.draw do
  require "sidekiq/web"

  devise_for :users
  root to: 'pages#home'
  resources :jobs do
    resources :shifts, except: :show do
      resources :requests, except: [:show]
      get 'requests/confirmation', to: 'requests#confirmation'
    end
  end

  patch '/shifts/close', to: 'shifts#close_shifts', as: :close_shifts

  get 'jobs/:id/close', to: 'jobs#close', as: :job_close

  resources :shifts, only: :show

  post 'shifts/:shift_id/reviews', to: 'reviews#create', as: :shift_reviews

  get '/dashboard', to: 'pages#dashboard'

  get '/dashboard_employer', to: 'pages#dashboard_employer'

  resources :users, only: [:edit, :update]

  resources :requests, only: [:show] do
    patch 'requests/:id/accept_request', to: 'shifts#accept_request', as: 'accept_request'
  end

  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
