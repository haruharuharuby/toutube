Rails.application.routes.draw do

  root :to => 'videos#index'

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'upload' => 'videos#new'

  resources :videos, except: [:delete, :edit, :update] do
    collection do
      get 'search'
    end
    member do
      post 'reputate'
    end
    resources :comments, except: [:edit, :new, :index, :show]
  end

  resources :channels, except: [:new, :edit, :update, :index] do
    # collection do
    #   get 'subscriptions'
    # end

    member do
      post 'register'
      # post 'change'
    end
  end

  resources :playlists, except: [:new, :edit, :update]
  # resources :reputations
  # comment は video だけにするので、うえの comments resouces で実装したい
  # resources :comments, only: [:create, :update, :destroy]

  # 自分のマイページであれば、 resource :user do が適切
  resource :user, except: [:index, :edit, :update] do
    member do
      get 'home'
      get 'videos'
      get 'playlists'
      get 'channels'
      get 'description'
    end
  end

end
