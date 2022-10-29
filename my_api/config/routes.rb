Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do 
      resources :books, only: [:index, :create, :destroy]

      post 'auth', to: 'authentication#create'
    end
  end
end
