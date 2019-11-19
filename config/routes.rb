Rails.application.routes.draw do
  devise_for :users
  root to: 'jobs#index'
  resources :jobs do
    resources :shifts do
      resources :requests, except: [:show]
    end
  end
  resources :dashboards, only: :show

  resources :requests, only: [:show] do
    patch 'requests/:id/accept_request', to: 'shifts#accept_request', as: 'accept_request'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
