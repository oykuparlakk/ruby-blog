Rails.application.routes.draw do
  scope "(:locale)", locale: /en|tr/ do
    root "articles#index"

    resources :articles do
      resources :comments, only: [ :create, :destroy ], param: :article_id
      collection do
        get "search", to: "articles#search"
      end
    end
  end
end
