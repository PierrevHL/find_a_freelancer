Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :profiles, except: [:destroy] do
    member do
      get :edit_rates
    end
  end

  resources :profile_skills, except: [:destroy] do
    resources :bookings, only: [:create]
  end

  resources :bookings, only: [] do
    resources :user_reviews, only: [:index, :new, :create]
    resources :freelancer_reviews, only: [:index, :new, :create]
  end

  resources :conversations, only: [:index, :show, :create] do
    resources :messages, only: [:index, :new, :create]
  end

  get "/dashboard", to: "pages#dashboard"
end

