Rails.application.routes.draw do
  resources :home
  root 'home#top'
  #likes action
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"
  #users　action
  get "users/:id/likes" => "users#likes"
  get "users/new" => "users#new"
  post "users/create" => "users#create"

  get "users/:id/edit" =>"users#edit"
  post "users/:id/update" =>"users#update"

  post "users/:id/destroy" =>"users#destroy"
  get "users/index" =>"users#index"
  
  get "users/login" =>"users#login_form"
  post "users/login" =>"users#login"
  post "users/logout" =>"users#logout"

  get "users/:id" =>"users#show"
  #posts action
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"

  get "posts/index" => "posts#index"

  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"

  post "posts/:id/destroy" => "posts#destroy"
  get "posts/:id" => "posts#show"
  #home action
  get "/" => "home#top"
  get "/about" =>"home#about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
