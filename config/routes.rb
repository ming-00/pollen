Rails.application.routes.draw do
  get 'welcome/forum'
  get 'welcome/feed'
  get 'welcome/profile'
  get 'welcome/index'

  root 'welcome#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
