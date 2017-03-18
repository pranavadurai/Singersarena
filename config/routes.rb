Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :accounts do
    collection do
      get  'check_email'
      get  'email_check'
      get  'forget_password'
      get  'password_reset'
      get  'logo'
      get  'icon'
      get  'default_dp'
    end
  end

  resources :users do
    collection  do
      get  'image_display'
      post 'follow'
      post 'unfollow'
    end
  end

  resources :admins do
    collection do
      post 'default'
    end
  end

  resources :songs do
    collection do
      get 'like'
      get 'unlike'
    end
  end

  resources :comments

  resources :conversations do
    resources :messages
  end

  root to: 'songs#index'

  mount ActionCable.server => '/message'

  match '/signout' ,         to: 'accounts#signout',              via: [:delete]
  match '/login' ,           to: 'accounts#login',                via: [:post]
  match '/signin' ,          to: 'accounts#signin',               via: [:get]
  match '/signup',           to: 'accounts#new',                  via: [:get]

end
