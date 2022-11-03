Rails.application.routes.draw do
  root to: 'notifications#index'
  resources :messages
  mount ActionCable.server => '/cable'
end
