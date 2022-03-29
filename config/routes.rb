Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  namespace :api do
    namespace :v1 do
      resources :districts, only: [:index]
      resources :mandals, only: [:index]
      resources :villages, only: [:index] do
        collection do
          get :search
        end
      end
      resources :surveys, only: [:index]
      resources :land_records, only: [:index]
      get 'get_khata_no' => 'land_records#get_khata_no'
    end
  end
end
