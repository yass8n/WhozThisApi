Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
  	namespace :v1 do
  	root to: 'users#index'
    post "/users/sign_up", to: "users#create"
    post "/users/sign_in", to: "users#sign_in"
    get "/users/stream/:id", to: "users#stream"
    post "/users/friends", to: "users#friends"
    post "/conversation_users", to: "conversation_users#delete"
    resources :conversation_users

    resources :conversations

    resources :users

  	end
  end
end
