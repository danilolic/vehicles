Rails.application.routes.draw do
  namespace :api do
    resource :session, only: %i[create]
    resource :refresh, only: %i[create]

    resources :brands do
      resources :models, shallow: true do
        resources :vehicles, shallow: true
      end
    end
  end
end
