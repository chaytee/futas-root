Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # api test action
      resources :hello, only: [:index]
    end
  end

  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }

  resources :messages, only: [:index]

  get    '/relationships/invitation_code', to: "relationships#invitation_code"
  resources :relationships, only: [:index, :new, :create]
end