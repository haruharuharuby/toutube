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
  
  resources :users do
    resources :channels
  end

end
