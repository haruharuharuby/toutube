Rails.application.routes.draw do

  root :to => 'videos#index'

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'upload' => 'videos#new'

  resources :videos do
    collection do
      get 'search'
    end
    member do
      post 'reputate'
    end
    resources :comments
  end

  resources :channels do
    collection do
      get 'subscriptions'
    end

    member do
      post 'register'
    end
  end

  resources :playlists
  resources :reputations
  resources :comments

  resources :users do
    member do
      get 'home'
      get 'videos'
      get 'playlists'
      get 'channels'
      get 'description'
    end
  end

end
