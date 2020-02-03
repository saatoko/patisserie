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

  # ルーティングにAjax用のパスを指定
  root "users#index"
  
  resources :recipes do
    collection do
      get 'select_category'
      get 'category_children', defaults: { format: 'json' }
      get 'set_categories'
    end
  end
 
  # resources :categories
  resources :users do
    collection do
      get 'siteguide'
    end
  end

  resources :categories do  
    resources :recipes
  end
  resources :images, controller: "recipe_images" 
end
