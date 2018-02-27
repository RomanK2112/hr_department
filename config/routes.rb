Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'

  resources :employees

  namespace :admin do
    resources :admins

    resources :users, only: [:index, :show, :new, :create, :destroy, :update, :edit] do
      member do
        put '/toggle_admin', action: :toggle_admin, as: 'toggle'
      end
    end
  end
end
