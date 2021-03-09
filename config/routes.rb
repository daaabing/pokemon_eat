Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#welcome"
  post "/login", to: "users#login"
  post "/signup", to: "users#create"
  get "/search", to: "users#search"
  get "/question", to: "users#question", as: "question"
  post "/question_update", to: "users#question_update"
  post "/update", to: "users#update"
end
