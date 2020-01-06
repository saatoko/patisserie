Rails.application.routes.draw do

  # devise_for :users,
  # path: '',
  # path_names: {
  #   sign_up: '',
  #   sign_in: 'login',
  #   sign_out: 'logout',
  #   registration: "signup",
  # },
  # controllers: {
  #   registrations: 'users/registrations',
  #   sessions: 'users/sessions',
  # } ,
  # devise_scope: {
  #   get "signup":"users/registrations#new"
  #   get 'login' :'users/sessions#new'
  #   post 'login' :'users/sessions#create'
  #   delete 'logout' :'users/sessions#destroy'
  # }

  devise_for :users,
  path: '',
  path_names: {
    sign_up: '',
    sign_in: 'login',
    sign_out: 'logout',
    registration: "signup",
  },
  controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  # root "users#index"
  root "recipes#show"
  resources :recipes
  resources :users do
    collection do
      get 'siteguide'
    end
  end
end
