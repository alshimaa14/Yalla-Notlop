Rails.application.routes.draw do
  get 'notifications/index'
  #root to: 'notifications#index'
  resources :messages
  devise_for :users
  root 'welcome#index'
  resources :friendships
  # Websockets resemble this URL
  mount ActionCable.server => '/cable'

  resources :users do
  	collection do
      get :autocomplete
    end
    resources :groups do
      resources :members
    end
    resources :orders do
      patch :finish
      resources :items
      resources :order_friend_invitations do
        collection do
          get :joined
          get :uninvite
          get :join
        end
      end
    end
    resources :friends 
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
