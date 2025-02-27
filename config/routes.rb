Rails.application.routes.draw do
  scope "(:locale)", locale: /en|tr/ do
    devise_for :users, controllers: {
      sessions: "users/authentication/sessions",
      registrations: "users/authentication/registrations"
    }

    devise_scope :user do
      get "profile", to: "users/authentication/registrations#show", as: "user_profile"
      get "/users/sign_out" => "users/authentication/sessions#destroy"
    end

    root "articles#index"

    resources :articles do
      resources :likes, only: [ :create, :destroy ]
      resources :recommendations, only: [ :create, :new ]
      resources :comments, only: [ :create, :destroy ], param: :article_id
      collection do
        get "search", to: "articles#search"
      end
    end

    resources :tags, only: [ :index, :show ]

    get "categories", to: "pages#categories"
    get "about", to: "pages#about"
    get "contact", to: "pages#contact"

    get "recommendations", to: "recommendations#index", as: "recommendations"
  end
end
