Rails.application.routes.draw do
  get 'offer/new'
  require "sidekiq/web"

  devise_for :users
  root to: 'pages#home'
  resources :jobs do
    resources :favourites, only: [:create, :destroy]
    resources :shifts, except: :show do
      resources :orders, only: [:create]
      resources :requests, except: [:show]
      get 'requests/confirmation', to: 'requests#confirmation'
    end
  end
  resources :orders, only: [:show] do
    resources :payments, only: :new
  end

  resources :employees, only: [:index]

  patch '/shifts/close', to: 'shifts#close_shifts', as: :close_shifts

  get 'jobs/:id/close', to: 'jobs#close', as: :job_close
  get 'dashboard_employer/closed_jobs', to: 'jobs#closed_jobs', as: :closed_jobs
  get 'dashboard_employer/listed_jobs', to: 'jobs#listed_jobs', as: :listed_jobs


  resources :shifts, only: :show

  get 'users/:id/offers/select', to: 'offers#select', as: :new_user_offer
  get 'shifts/:id/users/:user_id/offers/new', to: 'offers#new', as: :new_shift_offer
  post 'shifts/:id/users/:user_id/offers', to: 'offers#create', as: :create_shift_offer

  get '/reviews', to: 'reviews#review_dashboard', as: :review_dashboard

  post 'shifts/:shift_id/reviews', to: 'reviews#create', as: :shift_reviews

  get '/dashboard', to: 'pages#dashboard'
  get 'dashboard/pending', to: 'requests#pending_requests', as: 'pending_requests'
  get 'dashboard/upcoming', to: 'shifts#upcoming_shifts', as: 'upcoming_shifts'
  get 'dashboard/historic', to: 'shifts#historic_shifts', as: 'historic_shifts'
  get 'dashboard/favourites', to: 'favourites#index', as: 'favourites'
  get '/dashboard_employer', to: 'pages#dashboard_employer'

  get '/dashboard/chats/:id', to: 'chats#inbox_show', as: :dashboard_chat

  get '/confirmation_page', to: 'pages#confirmation_page'

  get '/inbox', to: 'chats#inbox', as: :inbox

  get '/active_applications', to: 'requests#active_applications', as: :active_applications

  resources :chats, except: :create do
    resources :messages
  end

  resources :users, only: [:edit, :update, :index]


  resources :requests, only: [:show] do
    resources :chats, only: [:create]
  end
  patch 'requests/:id/accept_request', to: 'shifts#accept_request', as: 'accept_request'


  # authenticate :user, lambda { |u| u.admin } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end

  mount StripeEvent::Engine, at: '/stripe-webhooks'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
