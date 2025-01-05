Rails.application.routes.draw do
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Devise routes
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Root route
  root 'home#index'

  # Posts routes
  resources :posts do
    collection do
      get :autocomplete
    end
  end

  resources :tags, only: [:show]
  resources :contacts, only: [:new, :create]
end
