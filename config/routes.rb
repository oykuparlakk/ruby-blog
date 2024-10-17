Rails.application.routes.draw do
  root "articles#index"
  resources :articles do
    resources :comments, only: [:create, :destroy]
  end
  get "/articles", to: "articles#index"
  get "/articles/:id", to: "articles#show"
  delete "articles/:id", to:"articles#destroy"
end
