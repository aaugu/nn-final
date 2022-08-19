Rails.application.routes.draw do
	root to: 'pages#home'
	get 'about', to: 'pages#about'
	get 'contact', to: 'pages#contact'
  get 'news', to: 'pages#news'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
