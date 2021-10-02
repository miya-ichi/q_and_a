Rails.application.routes.draw do
  namespace :admin do
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'

    resources :users
    resources :questions
  end

  root to: 'questions#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users

  get 'questions/solved', to: 'questions#solved'
  get 'questions/unsolved', to: 'questions#unsolved'

  resources :questions do
    resources :answers
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
