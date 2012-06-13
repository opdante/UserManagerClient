Rails.application.routes.draw do

	match '/auth/:provider/callback', to: 'sessions#create'
  match '/signout', to: 'sessions#destroy', as: 'signout'
  match '/auth/usermanager', as: 'login'

  root to: 'home#index'

end
