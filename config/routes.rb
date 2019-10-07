Rails.application.routes.draw do

  get 'likes/create'
  get 'likes/destroy'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    registrations: 'users/registrations',
                                    sessions: 'users/sessions'
                                  # passwords: 'users/passwords'
  }
  root 'static_pages#home'
  get  '/home',   to: 'static_pages#home'
  get  '/edit_password', to: 'users#edit_password'
  patch  '/update_password', to: 'users#update_password'
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts,         only: [:new, :show, :create, :destroy] do
    resources :comments, only: [:create]
  end
  resources :relationships, only: [:create, :destroy]
  resources :likes,         only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
