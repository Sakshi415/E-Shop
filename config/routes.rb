Rails.application.routes.draw do
  resources :orders
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    # sessions: 'users/sessions',
    registrations: 'registrations'
  }
  root to: 'product#index'
  resources :categories
  resources :products do
    post :productcategory, on: :collection
    post :buy_product, on: :member
  end
  post '/admin/add_product_to_category', to: 'admin#add_product_to_category'
  post '/user/buy_product', to: 'user#buy_product'
  post '/user/add_product', to: 'user#add_product'
end

