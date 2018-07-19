require 'api_constraints.rb'

MarketPlaceApi::Application.routes.draw do
  devise_for :users
  namespace :api, defaults: {format: :json},
            constraints: {subdomain: 'api'}, path: '/' do
    scope module: :v1,
      constraints: ApiConstraints.new(version: 1, default: true) do
      # resources :users, only: [:show]
      resource :users do
        member do
          get 'show'
        end
      end
    end
  end
end
