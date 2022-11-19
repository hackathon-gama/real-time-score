# frozen_string_literal: true

Rails.application.routes.draw do
  get 'matches/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :file_import_teams, only: :create
      resources :file_import_matches, only: :create
      resources :direct_uploads, only: :create
      resources :users, only: %i[create]
    end
  end
end
