Rails.application.routes.draw do
  

  get 'sessions/new'

  root 'pages#Home'
  get  'users/show'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get	'/list', to:  'users#listuser'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  #patch  '/signup', to: 'users#update'
  get   '/edit', to: 'users#edit'
  patch '/edit', to: 'users#update'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
end
