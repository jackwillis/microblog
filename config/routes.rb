Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts
  devise_for :users

  get '/tag/:hashtag', to: 'posts#hashtag', as: 'hashtag'
  get '/@:username', to: 'users#show', as: 'user'
end
