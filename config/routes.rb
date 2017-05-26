Rails.application.routes.draw do
  get 'sessions/new'

  resources :users
  root 'users#new'

  get 'static_pages/help'
  get 'signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
