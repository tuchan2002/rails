Rails.application.routes.draw do
  resources :friends
  root 'friends#index'
end
