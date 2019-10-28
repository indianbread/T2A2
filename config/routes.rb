Rails.application.routes.draw do
  get 'products/', to: "products#index", as: "products"
  get 'products/:id', to: "products#show", as:"product"
  get 'products/:id/edit', to:"products#edit", as: "edit_product"
  patch 'products/:id', to: 'products#update'
  get 'products/new', to:'products#new', as:'new_product'
  post '/products', to:'products#create'
  delete '/products/:id', to: 'products#destroy'
  get '/', to: "pages#index", as: "root"
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
