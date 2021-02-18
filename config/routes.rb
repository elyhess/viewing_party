Rails.application.routes.draw do
	root "welcome#index"

	get '/dashboard', to: 'dashboard#index', as: :dashboard

	get '/login', to: 'sessions#new'
	post '/login', to: 'sessions#create'
	delete '/logout', to: "sessions#destroy"

	post '/friendships', to: "friendships#create"
	get '/discover', to: "discover#index"

	resources :users, only: [:new, :create]
	resources :movies, only: [:index, :show, :create]
	resources :parties, only: [:new, :create]
end
