# frozen_string_literal: true
# require 'resque/server'
Rails.application.routes.draw do
  resources :users, only: [:show, :index, :create, :update, :destroy]
  devise_for :user, controllers: { confirmations: 'confirmations' }, defaults: { format: :json }
  post 'auth', to: 'auth#authenticate_user'
end
