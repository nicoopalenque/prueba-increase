require 'sidekiq/web' 
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :transaction, only: %i[index show]
      resources :client, only: %i[show]
    end
  end

  mount Sidekiq::Web => '/sidekiq'
end
