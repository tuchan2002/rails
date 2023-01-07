Rails.application.routes.draw do
  get 'books/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :books, only: [:index, :create, :destroy]
    end
  end
end
