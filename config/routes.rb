# frozen_string_literal: true
# require 'resque/server'
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :index, :create, :update, :destroy]
      post 'auth', to: 'auth#authenticate_user'
    end
  end
  get '/api' => redirect('/swagger/dist/index.html?url=http://localhost:3000/apidocs/api-docs.json')
  devise_for :user, defaults: { format: :json }
end
