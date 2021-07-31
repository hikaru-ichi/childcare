Rails.application.routes.draw do
  root to: 'posts#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create]
  
  get 'users/:id/child', to: 'children#new', as: :child_new
  post 'users/:id/child', to: 'children#create'

end
