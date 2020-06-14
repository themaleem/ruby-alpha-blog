Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles, only: %i[show index new create edit update destroy]
  get 'signup', to: 'users#new'
  resources :users, except: %i[new]
end
