Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


 get 'signup',to:'users#new'
 get 'login',to:'users#newlogin'
 post 'login',to:'users#login'
 delete 'logout',to:'users#logout'
 get 'index',to: 'blogs#index'
 get 'blogs/:id',to:'blogs#show',as:'blog_show'
 
 # resources :blogs do
 # 	resources :comments
 # 	resources :likes
 # end

 resources :users do
 	get '/profile',to:'users#profile',as:'profile'
 	member do
 		resources :blogs
 	end
 end
  resources :blogs do
 	resources :comments
 	resources :likes
 end
end
