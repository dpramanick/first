Rails.application.routes.draw do
  get 'users/show'
  get 'rooms/index'
  
  
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'pages#home'

  resources :interests 

  get 'admin/pending_approvals', to: 'admin#pending_approvals'
  get 'admin/confirmed_approvals', to: 'admin#confirmed_approvals'
  get 'admin/create_categories', to: 'admin#create_categories'
  get 'admin/seller', to: 'admin#seller'

  # Defines the route for approving and rejecting products
  get 'admin/approve_product/:id', to: 'admin#approve_product', as: 'approve_product'
  get 'admin/reject_product/:id', to: 'admin#reject_product', as: 'reject_product'

  match 'admin/approve_product/:id', to: 'admin#approve_product', via: %i[get patch]
  match 'admin/reject_product/:id', to: 'admin#reject_product', via: %i[get patch]

  patch 'admin/approve_product/:id', to: 'admin#approve_product'
  patch 'admin/reject_product/:id', to: 'admin#reject_product'

  #patch 'admin/seller_product/:id', to: 'admin#seller_product'
  #match 'admin/seller_product/:id', to: 'admin#seller_product', via: %i[get patch]
  #get 'admin/seller_product/:id', to: 'admin#seller_product', as: 'seller_product'


  devise_for :users

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  get 'user/:id', to: 'users#show', as: 'user'

  resources :rooms do
    resources :messages
  end

  get 'pages/map', to: 'pages#map'
  

  get '/products/:id/smail', to:'products#smail', as: 'smail_product'

  get '/products/:id/sell', to:'products#sell', as: 'sell_product'

  get 'messages', to: 'static_pages#messages'
  get 'messages/open', to: 'messages#create'

  get '/account/', to: 'pages#account', as: 'show_current_account'
  get '/payments/success', to: 'payments#success', as: 'success_payment'
  get '/payments/failure', to: 'payments#failure', as: 'failure_payment'
  post '/payments/webhook', to: 'payments#webhook'
end

