Rails.application.routes.draw do
  get 'sessions/new'

  resources :users
  resources :tasks
  
  # root 'users#new'
  root 'static_pages#index'

  get 'static_pages/help'
  get 'signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Login with Facebook  
  get '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
