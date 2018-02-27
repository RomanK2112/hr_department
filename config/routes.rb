Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'

  resources :employees

  namespace :admin do
    resources :admins do
      collection do
        get '/manage_users', action: :manage_users, as: 'manage_users'
      end
    end
    
    resources :users, only: [:index, :show, :new, :create, :destroy, :update, :edit] do
      collection do
        put '/toggle_admin', action: :toggle_admin, as: 'toggle'
      end
    end
  end
end
