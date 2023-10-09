Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  namespace :api do
    # resources :users, only: %i[create index]
    resources :users do
      member do
        get :followings
				get :followers
				get :mates
				get :muting_users
				get :blocking_users
				get :seen_followers
				# get :hackmd_account
      end
			collection do
				get :hackmd_account
			end
			resources :memos, only: %i[index update]
    end
    resource :session, only: %i[create]
    resources :relationships, param: :followed_id, only: %i[create destroy]
    resources :mute_users, param: :muted_id, only: %i[create destroy]
    resources :block_users, param: :blocked_id, only: %i[create destroy]
    resources :seen_followers, param: :passive_user_id, only: :create
		resources :memos, only: %i[create destroy]
		resource :hackmd_account, only: %i[create destroy]
		resources :hackmd_archives, only: %i[create destroy index]
		resources :hackmd_user_notes, only: %i[index]

    namespace :me do
      resource :account, only: %i[update destroy]
    end
  end
end
