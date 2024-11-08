Rails.application.routes.draw do
  namespace :api do
    resource :session, only: [:create, :destroy], path: 'sessions'

    resource :user, only: [:create] do
      get '/', to: 'users#details', as: :details
    end

    namespace :users, path: 'user' do
      resource :game_events, only: [:create]
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
