Rails.application.routes.draw do
  root to: 'posts#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create]
  
  get 'users/:id/child', to: 'children#new', as: :child_new
  post 'users/:id/child', to: 'children#create'
  
  get 'users/:id/messages', to: 'messages#index', as: :messages
  get 'users/:id/message', to: 'messages#new', as: :message_new
  post 'users/:id/message', to: 'messages#create'
  delete '/messages/:id(.:format)', to: 'messages#destroy', as: :message
  
  resources :posts, only: [:index, :show, :new, :create, :delete]

end
