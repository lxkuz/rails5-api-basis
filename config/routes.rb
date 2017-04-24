# frozen_string_literal: true
# require 'resque/server'

CRUD = [:create, :show, :index, :update, :destroy].freeze

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: CRUD
      post 'auth', to: 'auth#authenticate_user'
      resources :tickets, only: CRUD
      resources :ticket_kinds, only: CRUD
      resources :reports, only: CRUD
      get 'export/reports/:id', to: 'exports#report'
    end
  end
  # devise_for :user, defaults: { format: :json }
end
