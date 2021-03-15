Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "users#welcome"
  post "/login", to: "users#login"
  post "/signup", to: "users#signup"
  get "/search/:id", to: "users#search"
  get "/question", to: "users#question", as: "question"
  post "/question_update", to: "users#question_update"
  post "/update", to: "users#update"
end
