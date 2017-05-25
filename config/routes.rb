Rails.application.routes.draw do
  resources :users
  root 'users#new'

  get 'static_pages/help'
  get 'signup', to: 'users#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
