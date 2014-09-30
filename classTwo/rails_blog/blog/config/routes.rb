Blog::Application.routes.draw do

  resources :users

  resources :articles do
    resources :comments
  end

  root 'welcome#index'
end
