Rails.application.routes.draw do
  get 'brands/index'
  get 'brands/edit'
  get 'brands/new'
  get 'brands/destroy'
  get 'user_infos/index'
  get 'user_infos/show'
  get 'user_infos/edit'
  get 'user_infos/destroy'
  get 'user_info/index'
  get 'user_info/show'
  get 'user_info/edit'
  get 'user_info/new'
  get 'user_info/destroy'
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
  delete '/products/:id', to: 'products#destroy'

  get 'categories/:id', to: "categories#show", as:"category"
  patch 'categories/:id', to: 'categories#update'
  delete '/categories/:id', to: 'categories#destroy'
  get 'categories/:id/edit', to:"categories#edit", as: "edit_category"
  get 'categories/new', to:'categories#new', as:'new_category'
  get 'categories/', to: "categories#index", as: "categories"
  post '/categories', to:'categories#create'
  
  get '/users/:id/user_infos', to:"user_infos#index", as: "user_user_info"
  patch '/users/:id/user_infos', to:"user_infos#update"
  delete '/users/:id/user_infos', to:"user_infos#destroy"
  get '/users/:id/user_infos/edit', to:"user_infos#edit", as: "edit_user_user_info"
  get '/users/:id/user_infos/new', to:"user_infos#new", as: "new_user_user_info"
  post '/users/:id/user_infos', to:"user_infos#index", as: "user_user_info"

 


  get '/', to: "pages#index", as: "root"





  devise_for :users
  get "*path", to: "pages#not_found", constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
