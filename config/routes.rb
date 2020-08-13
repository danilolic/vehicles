Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resource :session, only: %i[create]
    resource :refresh, only: %i[create]

    resources :brands do
      resources :models, shallow: true do
        resources :vehicles, shallow: true
      end
    end
  end
end
