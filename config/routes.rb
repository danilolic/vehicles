Rails.application.routes.draw do
  resources :brands
  namespace :api do
    resource :session, only: %i[create]
    resource :refresh, only: %i[create]
  end
end
