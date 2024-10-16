Rails.application.routes.draw do
  root "articles#index"
  resources :articles
  get "/articles", to: "articles#index"
  get "/articles/:id", to: "articles#show"
  delete "articles/:id(.:format)", to:"articles#destroy"
end
