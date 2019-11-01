Rails.application.routes.draw do

  get '/admindashboard', to: "pages#admin_dashboard", as: "admin_dashboard"
  get '/userdashboard', to: 'pages#user_dashboard', as: 'user_dashboard'

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
  post '/users/:id/user_infos', to:"user_infos#create"
  get '/users/:id/order_lines', to:'order_lines#index', as: 'order_lines'
  # get '/users/:id/cart', to:'carts#show', as:'show_cart'
  post '/users/:id/order_lines', to:'order_lines#create'
  delete '/users/:id/order_lines', to: 'order_lines#destroy'
  get '/users/:id/cart', to:'carts#show', as: 'cart'

  get '/payments/success', to: 'payments#success'
  post 'payments/webhook', to: 'payments#webhook'

  get '/', to: "pages#index", as: "root"

  get '/addresses', to: 'addresses#index', as: 'addresses'
  post '/addresses', to: 'addresses#create'
  get '/addresses/new', to: 'addresses#new', as: 'new_address'
  get '/addresses/:id', to: 'addresses#show', as: 'address'
  delete '/addresses/:id', to: 'addresses#destroy'
  get '/addresses/:id/edit', to: 'addresses#edit', as: 'edit_address'
  patch '/addresses/:id', to: 'addresses#update'


  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations"
  } 

  get '/not_authorised', to: 'pages#not_authorised', as: 'not_authorised'
  get "*path", to: "pages#not_found", constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
