Rails.application.routes.draw do
  root 'posts#index'
  get '/h/:hashtag', to: 'posts#hashtag', as: 'hashtag'

  resources :posts
end
