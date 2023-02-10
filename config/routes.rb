Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :categories, except: %i[show]
  resources :products, path: "/"

  namespace :auth, path: '', as: '' do
    resources :users, only: %i[new create]
    resources :sessions, only: %i[new create destroy]
  end
end
