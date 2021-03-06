UserManagerClient::Engine.routes.draw do

  match '/auth/usermanager/callback', to: 'sessions#create'
  match '/signout', to: 'sessions#destroy', as: 'logout'
  match '/auth/usermanager', as: 'login'
  match '/auth/redirect', to: 'sessions#redirect'

end
