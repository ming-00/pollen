Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, only: [:create]

  resource  :session,
    :controller => 'sessions',
    :only => [:new, :create, :destroy]

  match '/sign_out' => 'sessions#destroy', :via => :delete 

  #routes from clearance
  resources :users, only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  post "/sign_in" => "clearance/sessions#create"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  
  get 'forum'   => 'welcome#forum'
  get 'feed'    => 'welcome#feed'
  get 'profile' => 'welcome#profile'
  get 'entries/new' => 'entries#new'

  get "/session", to: redirect("/sign_in")
  get "/entries", to: redirect("/entries/new")

  Rails.application.routes.draw do
  
    constraints Clearance::Constraints::SignedIn.new do
      root to: "welcome#index", as: :signed_in_root
    end
  
    constraints Clearance::Constraints::SignedOut.new do
      root to: "welcome#landing"
    end
  end

  resources :users, only: [:index, :show, :update, :edit]
  resources :journals, only: [:show, :create, :destroy]
  resources :forumposts, only: [:new, :create, :destroy, :show, :edit, :update, :search] do
    resources :forumpostlikes, only: [:create, :destroy]
    resources :commentforums
    collection do
      get :search
    end
  end

  resources :tags, only: [:index, :show]
  resources :relationships, only: [:create, :destroy]
  resources :entries, only: [:show, :create, :update, :edit, :destroy, :new] do
    resources :entrylikes, only: [:create, :destroy]
  end
  resources :corrections, only: [:create, :index, :destroy, :edit, :update] do
    resources :correctionlikes, only: [:create, :destroy]
  end

  resources :users do
    member do
      get :following, :followers
    end
  end
  
  match "entries/:id/markresolved" => "entries#markresolved", :as => "markresolved_entry", via: [:get, :post]
  match "corrections/:id/markaccepted" => "corrections#markaccepted", :as => "markaccepted_correction", via: [:get, :post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
