Rails.application.routes.draw do
  devise_for :user, only: []

  namespace :v1, defaults: { format: :json } do
    resource :login, only: [:create], controller: :sessions
    resources :users, only: [:create]
    resources :users, only: [] do
      resources :todos, only: [:create, :update, :destroy]
    end
  end
end
