Rails.application.routes.draw do
  resources :users
  root 'home#index'

  resources :users, only: [:create, :destroy, :edit]
  get '/club', to: 'users#index'
  get '/register', to: 'users#new'

  delete '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
