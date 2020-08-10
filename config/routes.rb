Rails.application.routes.draw do
  namespace :api do
    resource :session, only: %i[create]
  end
end
