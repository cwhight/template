Rails.application.routes.draw do
  require "sidekiq/web"

  devise_for :users
  root to: 'pages#home'
  resources :jobs do
    resources :shifts, except: :shows do
      resources :orders, only: [:create]
      resources :requests, except: [:show]
      get 'requests/confirmation', to: 'requests#confirmation'
    end
  end
  resources :orders, only: [:show] do
    resources :payments, only: :new
  end


  patch '/shifts/close', to: 'shifts#close_shifts', as: :close_shifts

  get 'jobs/:id/close', to: 'jobs#close', as: :job_close

  resources :shifts, only: :show


  post 'shifts/:shift_id/reviews', to: 'reviews#create', as: :shift_reviews

  get '/dashboard', to: 'pages#dashboard'

  get '/dashboard_employer', to: 'pages#dashboard_employer'


  resources :chats, except: :create do
    resources :messages
  end

  resources :users, only: [:edit, :update]

  resources :requests, only: [:show] do
    patch 'requests/:id/accept_request', to: 'shifts#accept_request', as: 'accept_request'
    resources :chats, only: :create
  end

  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  mount StripeEvent::Engine, at: '/stripe-webhooks'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
