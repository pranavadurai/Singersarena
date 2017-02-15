Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :users do
    collection  do
      get  'check_email'
      get  'image_display'
      post 'follow'
      post 'unfollow'
    end
  end

  resources :songs do
    collection do
      get 'like'
      get 'unlike'
    end
  end

  resources :comments

  root to: 'songs#index'

  match '/signout' ,         to: 'users#signout',              via: [:delete]
  match '/login' ,           to: 'users#login',                via: [:post]
  match '/signin' ,          to: 'users#signin',               via: [:get]
  match '/signup',           to: 'users#new',                  via: [:get]

end
