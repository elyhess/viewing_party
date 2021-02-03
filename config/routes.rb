Rails.application.routes.draw do
	root "welcome#index"

	get '/dashboard', to: 'dashboard#index', as: :dashboard

	get '/login', to: 'sessions#new'
	post '/login', to: 'sessions#create'
	get '/logout', to: "sessions#destroy"

	resources :users, only: [:new, :create]
end
