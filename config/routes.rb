Rails.application.routes.draw do
  namespace :api do
    resources :brands
    resource :session, only: %i[create]
    resource :refresh, only: %i[create]
  end
end
