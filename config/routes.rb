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

  resources :questions do
    collection do
      get 'solved', to: 'questions#solved'
      get 'unsolved', to: 'questions#unsolved'
    end

    resources :answers
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
