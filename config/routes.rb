Rails.application.routes.draw do

  root :to => 'videos#index'

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'upload' => 'videos#new'

  resources :channels, except: [:new, :edit, :update]

  resources :videos, except: [:delete, :edit, :update] do
    resources :playlist_video_relation, only:[:create, :destroy]
    collection do
      get 'search'
    end
    member do
      post 'reputate'
    end
    resources :comments, except: [:edit, :new, :index, :show]
  end

  resource :user, except: [:index, :edit, :update] do
    resources :subscriptions, only: [:create, :update, :destroy]
    resources :playlists, only: [:index, :create, :update, :destroy]
    member do
      get 'home'
      get 'videos'
      get 'playlists'
      get 'channels'
      get 'description'
    end
  end

end
