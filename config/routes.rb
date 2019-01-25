Rails.application.routes.draw do
  root 'welcome#index'

  match '/login', to: 'sessions#new', via: :get
  match '/login', to: 'sessions#create', via: :post
  match '/logout', to: 'sessions#destroy', via: :delete

  match 'entities/new' => 'entities#new', via: :get
  match 'entities/new' => 'entities#create', via: :post
  match 'entities/:id' => 'entities#show', via: :get
  match 'entities/:id' => 'entities#update', via: :post
  match 'entities/:id/edit' => 'entities#edit', via: :get
  resources :entities

  resources :users
end
