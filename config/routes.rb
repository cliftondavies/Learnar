Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users

  resources :users, only: [:show] do
    resources :followings, only: %i[create destroy]
  end

  resources :progress_updates, only: %i[index create]
end
