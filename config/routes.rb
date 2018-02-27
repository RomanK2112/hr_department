Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'

  resources :employees

  namespace :admin do
    resources :admins
  end
end
