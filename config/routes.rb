Rails.application.routes.draw do
  root to: 'users#index'
  devise_for :users
  delete '/users/:user_id/posts/:id/destroy', to: 'posts#destroy', as: 'posts/destroy'
  delete '/comments/:id', to: 'comments#destroy', as: 'posts/destroy/comment'
  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:user_id/posts', to: 'posts#index', as: "posts"
  post '/users/:user_id/posts', to: 'posts#create'
  get '/users/:user_id/posts/:id', to: 'posts#show', as: 'posts/show'
  post '/users/:user_id/posts/:id/like', to: 'posts#like', as: 'posts/like'

  post '/users/:user_id/posts/comment', to: 'comments#create', as: "comments"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
