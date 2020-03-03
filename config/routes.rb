Rails.application.routes.draw do
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

  root "users#index"
  
  resources :recipes do
    collection do
      get 'category_children', defaults: { format: 'json' }
      get 'set_categories'
    end
    resources :votes, only: [:create, :destroy]
  end
 
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