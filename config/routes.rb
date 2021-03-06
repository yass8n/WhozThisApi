Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
  	namespace :v1 do
  	root to: 'users#index'
    post "/users/sign_up", to: "users#create"
    post "/users/sign_in", to: "users#sign_in"
    get "/users/stream/:id", to: "users#stream"
    post "/users/friends", to: "users#friends"
    get "/users/blocked/:id", to: "users#blocked"
    put "/conversation_users/delete", to: "conversation_users#delete"
    resources :conversation_users

    resources :conversations

    resources :users

    resources :blocked_users

  	end
  end
end
