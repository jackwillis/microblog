Rails.application.routes.draw do
  get '/', to: 'posts#index'
  get '/h/:hashtag', to: 'posts#hashtag', as: 'hashtag'

  resources :posts
end
