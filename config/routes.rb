Rails.application.routes.draw do

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/signout', to: 'sessions#destroy', as: 'logout'
  match '/auth/usermanager', as: 'login'
  match '/auth/redirect', to: 'sessions#redirect'

  root to: 'home#index'

end
