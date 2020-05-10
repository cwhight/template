Rails.application.routes.draw do

  require "sidekiq/web"

  get 'stripe/oauth', to: 'users#stripe_sign_up'
  devise_for :users
  root to: 'pages#home'

# JOBS

  resources :jobs do
    resources :favourites, only: [:create, :destroy]
    resources :shifts, except: :show do
      resources :orders, only: [:create]
      resources :requests, except: [:show]
      get 'requests/confirmation', to: 'requests#confirmation'
    end
  end
  get 'jobs/:id/close', to: 'jobs#close', as: :job_close
  post 'jobs/sort_pay', to: 'jobs#order_by_pay'
  get 'job/order_by_pay', to: 'jobs#order_by_pay', as: :sort_pay
  get 'job/filter', to: 'jobs#filter', as: :job_filter

# Payments

  resources :orders, only: [:show] do
    resources :payments, only: :new
  end
  get '/confirmation_page', to: 'pages#confirmation_page'

# Shifts

  patch '/shifts/close', to: 'shifts#close_shifts', as: :close_shifts
  get 'shifts/:id/users/:user_id/offers/new', to: 'offers#new', as: :new_shift_offer
  post 'shifts/:id/users/:user_id/offers', to: 'offers#create', as: :create_shift_offer
  post 'shifts/:shift_id/reviews', to: 'reviews#create', as: :shift_reviews
  resources :shifts, only: :show

# Offers

  resources :offers, only: :show
  patch 'offers/:id/accept_offer', to: 'shifts#accept_offer', as: 'accept_offer'

# Requests

  resources :requests, only: [:show] do
    resources :chats, only: [:create]
  end
  patch 'requests/:id/accept_request', to: 'shifts#accept_request', as: 'accept_request'

# Applications

  get '/active_applications', to: 'requests#active_applications', as: :active_applications

# Users

  get 'users/:id/offers/select', to: 'offers#select', as: :new_user_offer
  resources :users, only: [:edit, :update]
  get 'user/search', to: 'users#filter', as: :users_filter
  get 'user/sort_score', to: 'users#order_by_score', as: :users_sort_score

  get '/employees', to: 'users#index', as: :users

# Reviews

  get '/reviews', to: 'reviews#review_dashboard', as: :review_dashboard

# Dashboard

  get 'dashboard_employer/closed_jobs', to: 'jobs#closed_jobs', as: :closed_jobs
  get 'dashboard_employer/listed_jobs', to: 'jobs#listed_jobs', as: :listed_jobs
  get '/dashboard_employer', to: 'pages#dashboard_employer'

  get '/dashboard', to: 'pages#dashboard'
  get 'dashboard/pending', to: 'requests#pending_requests', as: 'pending_requests'
  get 'dashboard/upcoming', to: 'shifts#upcoming_shifts', as: 'upcoming_shifts'
  get 'dashboard/historic', to: 'shifts#historic_shifts', as: 'historic_shifts'
  get 'dashboard/favourites', to: 'favourites#index', as: 'favourites'
  get '/dashboard/chats/:id', to: 'chats#inbox_show', as: :dashboard_chat


# Chat

  resources :chats, except: :create do
    resources :messages
  end
  get '/inbox', to: 'chats#inbox', as: :inbox


  # authenticate :user, lambda { |u| u.admin } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end

  mount StripeEvent::Engine, at: '/stripe-webhooks'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
