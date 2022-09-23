Rails.application.routes.draw do
  resources :lists
  resources :posts
  root to: 'home#index'
end
