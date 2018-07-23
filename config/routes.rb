require 'api_constraints.rb'

MarketPlaceApi::Application.routes.draw do
  # devise_for :users
  # namespace :api, defaults: {format: :json},
  #           constraints: {subdomain: 'api'}, path: '/' do
  #   scope module: :v1,
  #     constraints: ApiConstraints.new(version: 1, default: true) do
  #
  #     # resources :users
  #     resources :users, only: [:show]
  #     # resources :users do
  #     #   member do
  #     #     get 'show'
  #     #   end
  #     # end
  #   end
  # end


  devise_for :users
  namespace :api do
    namespace :v1, controller: 'api/v1' do

      resources :users, only: [:show]
      # get 'users' => 'users#show'
    end
  end
end
