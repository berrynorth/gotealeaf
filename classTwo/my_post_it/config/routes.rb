PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  # manual route to new user registration
  get '/register', to: 'users#new'
  # manual routes for user session
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :posts, except: [:destroy] do
    # maps URL 'posts/:id/vote' to posts#vote
    member do
      post 'vote'
    end

    resources :comments, only: [:create] do
      member do
        post 'vote'
      end
    end
  end
  resources :categories, only: [:new, :create, :show]
  resources :users, except: [:index, :new, :destroy]
end
