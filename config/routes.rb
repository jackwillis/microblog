Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts

  get '/h/:hashtag', to: 'posts#hashtag', as: 'hashtag'

  get '/u/:username', to: 'users#show', as: 'user'

  devise_for :users
end
