Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  get '/h/:hashtag', to: 'posts#hashtag', as: 'hashtag'

  resources :posts
end
