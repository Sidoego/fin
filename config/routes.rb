Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get root to: 'welcome#index'
  get 'search_stock', to: 'stock#search'
  get 'search_friend', to: 'user#search'
  get 'user', to: 'user#index'
  get 'friend', to: 'user#show_friend'
  get 'friends_list', to: 'user#friends_list'
  get 'stock', to: 'stock#index'

end
