# frozen_string_literal: true

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :direct_uploads, only: :create
      resources :file_import_teams, only: :create
      resources :file_import_matches, only: :create
      resources :matches, only: [] do
        scope module: :matches do
          resources :interactions, only: %i[index create update destroy]
        end
      end
      resources :users, only: %i[create]
    end
  end
end
