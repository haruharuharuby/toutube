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
    resources :comments, except: [:edit, :new, :index, :show]
  end
  resources :playlist_video_relations, only: [:create, :destroy]
  resources :subscriptions, only: [:create, :update, :destroy]

  resource :user, except: [:index, :update] do
    resources :channels
    resources :subscriptions, only: [:index]
    resources :videos, only: [:index]
    resources :playlists, only: [:index, :show, :create, :update, :destroy]
    resources :comments, except: [:edit, :new, :index, :show]
  end
end
