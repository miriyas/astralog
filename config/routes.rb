Astralog::Application.routes.draw do

  # root to: 'main#index'
  # get '/' => 'main#index'

  get '/:id', to: 'posts#show'
  resources :posts

  namespace :admin do
    root :to => 'posts#index'
    
    get 'logout' => 'sessions#destroy', as: 'logout'
    get 'login' => 'sessions#new', as: 'login'
    post 'login' => 'sessions#create'
  
    get 'reload_parent_category'  
    resources :users
    resources :subjects
    resources :categories
    resources :posts
    resources :comments
    resources :users
  end 
end