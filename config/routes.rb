Easyblog::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :posts do
    resources :comments, :only => [:create] do
      post :mark_as_not_abusive, :on => :member
    end
    member do
      post :mark_archived
      get :comments
    end
  end
end
