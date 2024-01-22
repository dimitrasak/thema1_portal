Rails.application.routes.draw do
  get 'posts_feed/create'
  get 'posts_feed/store'
  get 'posts_feed/index'
  post 'posts_feed/store'
  get 'chats/create'
  get 'chats/new'
  get 'chats/show'
  get 'chats/index'
  devise_for :users, controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations',
    omniauth_callbacks: 'user/omniauth_callbacks',
    confirmations: 'user/confirmations',
    unlocks: 'user/unlocks'
  }

  devise_scope :user do
    get 'login', to: 'devise/sessions#new' #change route from /users/sign_in to /login
    get 'users/sign_out', to: 'users/sessions#destroy'
    get 'signup', to: 'devise/registrations#new' #change route from /users/signup to /signup

    #get '/users/auth/:provider/passthru', to: 'user/omniauth_callbacks#passthru', as: :user_omniauth_passthru
    #get "/users/auth/google_oauth2" => "users/omniauth_callbacks#passthru"

    
    
  end

  resources :posts do
    member do
      post 'add_like', to: 'posts#add_like', as: 'add_like_post'
    end
    get 'posts', to: 'posts#index', as: 'posts'

  end
        
  resources :chats do
    get 'chats', to: 'chats#index', as: 'chats'
  end
  
  #get 'posts/:id/add_like', to: 'posts#add_like', as: 'add_like_post'

  root 'welcome#index'
  
end
