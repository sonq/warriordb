Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  #
  root "home#index"

  get  "sign_up", to: "sign_up#new"
  post "sign_up", to: "sign_up#create"

  get  "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  delete "sign_out", to: "sessions#destroy"

  resources :academies, only: [ :index, :new, :create, :show ]
  resource :warrior, except: [ :destroy ]
  resources :events do
    resources :applications, only: [ :new, :create ], controller: "event_applications"
    resources :divisions, only: [ :index ] do
      collection do
        post :generate
      end
    end
  end
# config/routes.rb
resources :event_applications, only: [ :index, :show, :new, :create ],
path: "my-applications",
as: "my_applications"

namespace :admin do
  resources :event_applications, only: [ :index, :update ]
end
end
