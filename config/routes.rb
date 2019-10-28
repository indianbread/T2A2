Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/show'
  get 'categories/edit'
  get 'categories/delete'
  get 'products/', to: "products#index", as: "products"
  get 'products/new', to:'products#new', as:'new_product'
  post '/products', to:'products#create'
  get 'products/:id', to: "products#show", as:"product"
  get 'products/:id/edit', to:"products#edit", as: "edit_product"
  patch 'products/:id', to: 'products#update'
  delete '/products/:id', to: 'products#delete'

  get 'categories/:id', to: "categories#show", as:"category"
  patch 'categories/:id', to: 'categories#update'
  delete '/categories/:id', to: 'categories#delete'
  get 'categories/:id/edit', to:"categories#edit", as: "edit_category"
  get 'categories/new', to:'categories#new', as:'new_category'
  get 'categories/', to: "categories#index", as: "categories"
  post '/categories', to:'categories#create'
  
 


  get '/', to: "pages#index", as: "root"





  devise_for :users
  get "*path", to: "pages#not_found", constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
