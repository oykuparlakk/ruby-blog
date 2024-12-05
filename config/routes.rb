Rails.application.routes.draw do
  scope "(:locale)", locale: /en|tr/ do
    devise_for :users, path: "users", controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"

    }
    devise_scope :user do
      get "/users/sign_out" => "devise/sessions#destroy"
    end

    root "articles#index"

    resources :articles do
      resources :comments, only: [ :create, :destroy ], param: :article_id
      collection do
        get "search", to: "articles#search"
      end
    end

    get "categories", to: "pages#categories"
    get "about", to: "pages#about"
    get "contact", to: "pages#contact"
  end
end
