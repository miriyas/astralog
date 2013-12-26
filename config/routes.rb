Astralog::Application.routes.draw do
  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"

  resources :comments

  resources :posts
  resources :users

	resources :password_resets
end