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
  # get 'edit' => 'users#edit'
  # post'edit'   => 'users#update'
  # need to figure out how to get 'profile' => 'users#show'

  root :to      => 'welcome#index'
  resources :users, only: [:show, :update, :edit]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
