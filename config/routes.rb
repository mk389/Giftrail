Rails.application.routes.draw do
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get 'terms_of_service', to: 'pages#terms_of_service'
  get 'privacy_policy', to: 'pages#privacy_policy'

  # Devise routes
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords'
  }

  # Root route
  root 'home#index'

  # Posts routes
  resources :posts do
    resources :favorites, only: [:create, :destroy]
    collection do
      get :autocomplete
    end
  end

  resources :tags, only: [:show]
  resources :contacts, only: [:new, :create]

  get 'my_posts', to: 'posts#my_posts', as: 'my_posts'
  
  match '*path', to: 'application#not_found', via: :all
end
