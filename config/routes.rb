Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#welcome"
  post "/login", to: "users#login"
  post "/signup", to: "users#signup"
end
