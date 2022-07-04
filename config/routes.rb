Rails.application.routes.draw do
  get 'sessions/new'
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
