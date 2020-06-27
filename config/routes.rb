Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  #resource :session, controller: "clearance/sessions", only: [:create]
  resource :session, only: [:create]

  #routes from clearance
  resources :users, only: [:create] do #controller: "clearance/users"
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  
  get 'forum'   => 'welcome#forum'
  get 'feed'    => 'welcome#feed'
  get 'profile' => 'welcome#profile'
  get 'entries/new' => 'entries#new'

  root :to      => 'welcome#index'
  resources :users, only: [:index, :show, :update, :edit]
  resources :journals, only: [:show, :create, :destroy]
  resources :forumposts, only: [:create, :destroy, :show] do 
    resources :forumcomments
  end
  resources :tags, only: [:index, :show]
  resources :relationships, only: [:create, :destroy]

  resources :entries, only: [:show, :create, :update, :edit, :destroy]
  resources :corrections, only: [:create, :index, :destroy]

  #added from lihan
  #why does it need a comment
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
