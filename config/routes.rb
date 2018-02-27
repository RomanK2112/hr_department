Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'

  resources :employees

  namespace :admin do
    resources :admins

    resources :posts

    resources :groups, only: [:index, :edit, :new, :create, :update, :destroy] do
      collection do
        post '/add_member', action: :add_member, as: 'add_member'
      end
    end

    resources :users, only: [:index, :show, :new, :create, :destroy, :update, :edit] do
      member do
        put '/toggle_admin', action: :toggle_admin, as: 'toggle'
      end
    end
  end
end
