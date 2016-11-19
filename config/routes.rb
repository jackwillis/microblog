Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts
  post '/posts/:id/like', to: 'posts#like', as: 'like_post'
  delete '/posts/:id/like', to: 'posts#unlike', as: 'unlike_post'

  devise_for :users

  get '/tag/:hashtag', to: 'posts#hashtag', as: 'hashtag'
  get '/@:username', to: 'users#show', as: 'user'

  get '/notifications', to: 'notifications#index', as: 'notifications'
end
