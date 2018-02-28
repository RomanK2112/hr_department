Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'

  resources :employees, only: [:index, :edit, :update] do
    member do
      get '/show_post', action: :show_post, as: 'show_post'
    end
  end

  namespace :admin do
    resources :admins, only: [:index, :edit, :update]

    resources :posts

    resources :groups, only: [:index, :edit, :new, :create, :update, :destroy] do
      collection do
        post '/add_member', action: :add_member, as: 'add_member'
        delete '/destroy_member', action: :destroy_member, as: 'destroy_member'
      end
    end

    resources :users, only: [:index, :show, :new, :create, :destroy, :update, :edit] do
      member do
        put '/toggle_admin', action: :toggle_admin, as: 'toggle'
      end
    end
  end
end
