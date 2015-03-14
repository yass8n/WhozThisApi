Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
  	namespace :v1 do
  		
    resources :conversation_users

    resources :conversations

    resources :users

    root to: 'users#index'
    get "/users", to: "users#index"
  	end
  end
end
