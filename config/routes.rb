Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :users
  resources :songs

  root to: 'users#index'

  match '/signout' ,   to: 'users#signout',  via: [:delete]
  match '/login' ,   to: 'users#login',  via: [:post]
  match '/signin' ,   to: 'users#signin',  via: [:get]

end
