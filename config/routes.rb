Rails.application.routes.draw do
  devise_for :users
  root 'employees#index'

  resources :employees

  namespace :admin do
    resources :admins
  end
end
