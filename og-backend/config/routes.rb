Rails.application.routes.draw do
  resources :entities
  match '/entities/:id', to: 'entities#update', via: :post
  match '/entities/:id/delete', to: 'entities#delete', via: :delete

  match '/login', to: 'authentication#authenticate', via: :post
  match '/logout', to: 'authentication#destroy', via: :delete
end
