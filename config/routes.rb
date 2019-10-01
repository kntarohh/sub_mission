Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks',
                                  registrations: 'users/registrations',
                                  # passwords: 'users/passwords'
  }
  root 'static_pages#home'
  get  '/home',   to: 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
