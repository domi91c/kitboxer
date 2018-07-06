Rails.application.routes.draw do

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :stores
  namespace :my do
    resource :store, only: :show, controller: 'store'
    resources :users
    resources :orders, only: :index
    resources :reviews, only: :index
    resources :favorites, only: :index
  end

  resources :conversations do
    resources :messages, child: true, module: :conversations
  end

  resources :orders, shallow: true do
    resources :purchases, controller: 'orders/purchases', shallow: true do
      resource :review, controller: 'orders/purchases/review', only: [:new, :create, :edit, :update], shallow: true
      resources :conversations, controller: 'orders/purchases/conversations', shallow: true do
        resources :messages, controller: 'orders/purchases/conversations/messages', only: [:new, :create]
      end
    end
  end
  resources :subscriptions

  resources :products do
    resources :reviews, module: :products
    resource :publish, module: :products
    resources :build, controller: 'products/build'
    resources :favorites, controller: 'products/favorites', only: [:create, :update]
    resources :images, controller: 'products/images' do
      member do
        patch :set_cover_image
      end
    end
    resource :tutorial, controller: 'products/tutorial' do
      resources :steps, controller: 'products/tutorial/steps' do
        resources :images, controller: 'products/tutorial/steps/images'
      end
    end
  end


  resource :cart, only: [:show] do
    put 'add/:product_id', to: 'carts#add', as: :add_to
    get 'remove/:product_id', to: 'carts#remove', as: :remove_from
    put 'save_for_later/:product_id', to: 'carts#save_for_later', as: :save_for_later
  end

  root to: 'visitors#index'

end
