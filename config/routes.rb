Rails.application.routes.draw do

  root :to => 'videos#index'

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'upload' => 'videos#new'

  resources :channels, only: [:index, :show]

  resources :videos, except: [:delete, :edit, :update] do
    collection do
      get 'search'
    end
    member do
      post 'reputate'
    end
    resources :comments, except: [:edit, :new, :index, :show]
  end

  resources :playlist_video_relations, only:[:create, :destroy]

  resource :user, except: [:index, :update] do
    resources :subscriptions, only: [:index, :create, :update, :destroy]
    resources :playlists, only: [:index, :show, :create, :update, :destroy]
    resources :channels
    member do
      get 'home'
      get 'videos'
      get 'channels'
    end
  end

end
