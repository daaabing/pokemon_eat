Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "users#welcome"
  post "/login", to: "users#login"
  post "/signup", to: "users#signup"
  get "/search", to: "users#search"
  get "/question", to: "users#question"
  post "/question_update", to: "users#question_update"
  post "/update", to: "users#update"
  get "/home", to:"users#home"
  get "/business/:business_id", to:"businesses#show"
  get "/business/:business_id/review", to:"businesses#review"
  get "/events", to:"businesses#get_event_list"
  get "/event/:id", to:"businesses#get_event"
  get "/recommend", to: "users#recommend"
  get '/user', to: "users#show"
  get '/edit_profile', to:"users#edit"
  get '/like/:business_id', to:"businesses#like_res"
  get '/book/:event_id', to:"businesses#book_event"
  get '/other_user/:user_id', to:"users#other_user"
end
