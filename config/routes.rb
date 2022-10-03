Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  namespace :api do
    # resources :users, only: %i[create index]
    resources :users do
      member do
        get :followings, :followers, :mates, :applicants
      end
    end
    resource :session, only: %i[create]
    resources :relationships, param: :followed_id, only: [:create, :destroy]

    namespace :me do
      resource :account, only: %i[update destroy]
    end
  end
end
