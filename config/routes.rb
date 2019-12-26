Rails.application.routes.draw do

  # devise_for :users, controllers: {
  #   registrations: 'users/registrations',
  #   sessions: 'users/sessions'
  # } 

  # devise_scope :user do
  #   get "signup", to: "users/registrations#new"
  #   get "login", to: "users/sessions#new"
  #   delete "logout", to: "users/sessions#destroy"
  # end

  devise_for :users,
  path: '',
  path_names: {
    sign_up: 'signup',
    sign_in: 'login',
    sign_out: 'logout',
  },
  controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root "users#index"
  # root "recipes#show"
  resources :recipes
  resources :users do
    collection do
      get 'siteguide'
    end
  end
end
