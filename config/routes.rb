Rails.application.routes.draw do
  devise_for :users
  get 'dashboard', to: 'dashboard#index', as: :user_root

	root to: 'pages#home'
	get 'about', to: 'pages#about'
	get 'contact', to: 'pages#contact'
  get 'news', to: 'pages#news'
  resources :posts, only:[:new, :create, :edit, :update, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
