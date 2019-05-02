Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/random", to: "random#show"
        get "/most_revenue", to: "most_revenue#index"
        get "/most_items", to: "most_items#index"
        get "/:id/items", to: "items#index"
        get "/:id/invoices", to: "invoices#index"
        get "/revenue", to: "revenue_for_date#show"
        get "/:id/revenue", to: "revenue#show"
        get "/:id/favorite_customer", to: "favorite_customer#show"
      end
      resources :merchants, only: [:index, :show]

      namespace :customers do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/random", to: "random#show"
      end
      resources :customers, only: [:index, :show]

      namespace :invoices do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/random", to: "random#show"
      end
      resources :invoices, only: [:index, :show]

      namespace :items do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/random", to: "random#show"
        get "/most_revenue", to: "most_revenue#index"
      end
      resources :items, only: [:index, :show]

      namespace :transactions do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/random", to: "random#show"
      end
      resources :transactions, only: [:index, :show]

      namespace :invoice_items do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/random", to: "random#show"
      end
      resources :invoice_items, only: [:index, :show]
    end
  end
end
