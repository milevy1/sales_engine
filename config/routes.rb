Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/random", to: "random#show"
        get "/most_revenue", to: "most_revenue#index"
        get "/most_items", to: "most_items#index"
      end

      resources :merchants, only: [:index, :show]
    end
  end
end
