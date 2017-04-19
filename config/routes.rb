# frozen_string_literal: true
# require 'resque/server'
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :index, :create, :update, :destroy]
      post 'auth', to: 'auth#authenticate_user'
      resources :tickets, only: [:show, :index, :create, :update, :destroy]
      resources :ticket_kinds, only: [:show, :index, :create, :update, :destroy]
      resources :reports, only: [:show, :index, :create, :update, :destroy]
    end
  end
  #devise_for :user, defaults: { format: :json }
end
