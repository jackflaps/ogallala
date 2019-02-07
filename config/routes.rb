Rails.application.routes.draw do
  root 'welcome#index'

  match '/login', to: 'sessions#new', via: :get
  match '/login', to: 'sessions#create', via: :post
  match '/logout', to: 'sessions#destroy', via: :delete

  resources :entities
  match '/entities/:id', to: 'entities#update', via: :post
  match '/entities/:id/delete', to: 'entities#delete', via: :delete
  
  resources :users
end
