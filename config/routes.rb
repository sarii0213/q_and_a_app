Rails.application.routes.draw do
  resources :users

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :questions do
    collection do
      get :solved
      get :unsolved
    end

    member do
      post :solve
    end
    resources :answers, only: %i[create destroy]
  end

  namespace :admin do
    resources :users, only: %i[index destroy]
    resources :questions, only: %i[index destroy]
    get '/login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
  end
end
