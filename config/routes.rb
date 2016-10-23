Rails.application.routes.draw do
  root 'things#index'
  resources :things
end
