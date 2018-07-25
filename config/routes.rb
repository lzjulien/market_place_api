require 'api_constraints.rb'

MarketPlaceApi::Application.routes.draw do
  # devise_for :users
  # namespace :api, defaults: {format: :json},
  #           constraints: {subdomain: 'api'}, path: '/' do
  #   scope module: :v1,
  #     constraints: ApiConstraints.new(version: 1, default: true) do
  #
  #     # resources :users
  #     # resources :users, only: [:show]
  #     # resources :users do
  #     #   member do
  #     #     get 'show'
  #     #   end
  #     # end
  #   end
  # end


  devise_for :users
  scope module: :api do
    scope module: :v1 do
      resources :users, only: [:show, :create, :update, :destroy]
      # get 'users' => 'users#show'
      resources :sessions, only: [:create, :destory]
      resources :products, only: [:show, :index]
    end
  end
end
