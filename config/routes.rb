Rails.application.routes.draw do
  root "articles#index"

  resources :articles do
    resources :comments, only: [ :create, :destroy ]

    collection do
      get "search", to: "articles#search"
    end
  end
end
