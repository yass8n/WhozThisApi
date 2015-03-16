Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
  	namespace :v1 do
  	root to: 'users#index'
    post "/users/sign_up", to: "users#create"
    get "/users/sign_in", to: "users#sign_in"
    get "/users/stream/:id", to: "users#stream", format: 'json'
    post "/users/friends", to: "users#friends", format: 'json'
    resources :conversation_users

    resources :conversations

    resources :users

  	end
  end
end
