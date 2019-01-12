Rails.application.routes.draw do
  root 'welcome#index'

  match '/login', to: 'sessions#new', via: :get
  match '/login', to: 'sessions#create', via: :post
  match '/logout', to: 'sessions#destroy', via: :delete

  resources :entities
  resources :users
end
