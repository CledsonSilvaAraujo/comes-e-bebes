Rails.application.routes.draw do

  #Auth routes
  post 'auth/login'
  post 'auth/signup'
  post 'auth/create_owner'
  post 'auth/confirm'
  post 'auth/repeat_token'
  post 'auth/forgot'
  post 'auth/reset_password'
  
  #User Routes
  
  get 'users/:id', to: 'users#show'
  get 'users', to: 'users#index'
  get 'deliverymen', to: 'users#index_deliverymen'
  put 'deliverymen/:id', to: 'users#admit_deliveryman'
  delete 'deliverymen/:id', to: 'users#deny_deliveryman'
  put 'users/:id', to: 'users#update'
  delete 'users/:id', to: 'users#destroy'
  
  #Restaurant Routes 
  post 'restaurants', to: "restaurants#create"
  get 'restaurants/results/:id', to: "restaurants#results"
  get 'restaurants/:id', to: "restaurants#show"
  get 'restaurants/better_rated_restaurant', to: "restaurants#better_rated_restaurant"
  get 'restaurants', to: "restaurants#index"
  put 'restaurants/add_logo/:id', to: "restaurants#add_logo" 
  put 'restaurants/:id', to: "restaurants#update"
  delete 'restaurants/:id', to: "restaurants#destroy"
  
  #Dishes Routes
  post 'dishes', to: "dishes#create"
  get 'dishes', to: "dishes#index"
  get 'dishes/:id', to: "dishes#show"
  put 'dishes/add_dish_photo/:id', to: "dishes#add_dish_photo" 
  put 'dishes/change_quantity/:id', to: "dishes#change_quantity"
  put 'dishes/:id', to: "dishes#update"
  delete 'dishes/:id', to: "dishes#destroy"
  
  #Order Routes
  get 'orders/evaluate_order'
  get 'orders/is_confirmed'
  get 'orders/is_done', to: "orders#is_done"
  post 'orders/rate_an_order', to: 'orders#rate_an_order'
  post 'orders', to: "orders#create_cart" 
  get 'orders/:id', to: "orders#show"
  get 'orders', to: "orders#index"
  put 'orders/conclude_order/:id', to: "orders#conclude_order"
  #put 'orders/:id', to: "orders#update"
  delete 'orders/:id', to: "orders#destroy"
  
  #OrderDish Routes
  get 'order_dish', to: "order_dish#index"
  get 'order_dish/:order_id', to: "order_dish#show"
  post 'order_dish/add_item', to: "order_dish#add_item"
  post 'order_dish/remove_item', to: "order_dish#remove_item"
  get 'order_dish/update'
end
