PocPromoGem::Application.routes.draw do


  get "cart" => 'cart#index', as: :cart
  get "cart/checkout", as: :checkout
  post 'cart/checkout' => 'cart#proceed_checkout', as: :proceed_checkout
  post 'cart' => 'cart#add_product', as: :add_to_cart
  post 'cart/promo' => 'cart#add_promocode', as: :add_promocode
  delete 'cart' => 'cart#destroy_product', as: :remove_from_cart
  get "products" => 'products#index', as: :products
  get "product/:id" => 'products#show', as: :product

  get "orders" => "orders#index", as: :orders
  get "orders/:id" =>  "orders#show", as: :order
  get "orders/:id/confirm_payment" => 'orders#confirm_payment', as: :confirm_payment
  get "orders/:id/cancel_payment" => 'orders#cancel_payment', as: :cancel_payment
  
  root 'products#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
