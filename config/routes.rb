Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
  	namespace :v1 do
  	root to: 'users#index'
    post "/users/sign_up", to: "users#create"
    get "/users/sign_in", to: "users#sign_in"

    resources :conversation_users

    resources :conversations

    resources :users

  	end
  end
end
