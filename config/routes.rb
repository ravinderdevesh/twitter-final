Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  get '/' => 'home#index'
  post '/create_tweet' => 'home#create_tweet'
  post '/create_tweet_json' => 'home#create_tweet_json'

  post '/like' => 'home#like'
  post '/like_tweet_json' => 'home#like_tweet_json'
  post '/create_tweet_remote' => 'home#create_tweet_remote'

  post '/follow' => 'home#follow'

  get '/index_api' => 'home#index_api'

  get '/users' => 'home#users'
  get '/followers' => 'home#followers'
  get '/followees' => 'home#followees'

  get '/profile' => 'home#profile'
  post '/update_profile' => 'home#update_profile'
  get '/autocomplete_user_email' => 'home#autocomplete_user_email'

  post '/index_tweets' => 'home#index_tweets'
  mount Resque::Server, :at => "/resque"


  namespace :api do
    namespace :v1 do
      post '/sign_in' => 'users_api#sign_in'
      post '/generate_otp' => 'users_api#generate_otp'
      post '/verify_otp' => 'users_api#verify_otp'
      get '/feed' => 'users_logged_in#feed'
      get '/followers' => 'users_logged_in#followers'
      get '/followees' => 'users_logged_in#followees'

    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
