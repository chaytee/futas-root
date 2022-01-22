Rails.application.routes.draw do

  #テスト
  namespace :api do
    namespace :v1 do
      # api test action
      resources :hello, only: [:index]
    end
  end

  #current_user機能の追加
  devise_for :users
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'
  end
  # namespace :api do
  #   mount_devise_token_auth_for 'User', at: 'auth', controllers: {
  #     registrations: 'api/auth/registrations'
  #   }
  # end

  resources :relationships, only: [:create, :index]
  resources :tasks
end