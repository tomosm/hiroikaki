# frozen_string_literal: true

Rails.application.routes.draw do
  jsonapi_resources :documents

  root 'application#index'
end
