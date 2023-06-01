Rails.application.routes.draw do
  # users controller
  get '/signup' => 'users#signup_form'
  get '/login' => 'users#login_form'
  get '/users/index' => 'users#index'
  get '/users/:id' => 'users#edit'

  post '/login' => 'users#login'
  post '/logout' => 'users#logout'
  post '/users/create' => 'users#create'
  post '/users/:id/update' => 'users#update'

  # posts controller
  get '/' => 'posts#index'
  get '/posts/:id' => 'posts#article'
  get '/posts/:id/edit' => 'posts#edit'
  get '/posts/:id/new_post' => 'posts#new_post_form'

  post '/posts/:id/new_post' => 'posts#new_post'
  post '/posts/:id/update' => 'posts#update'
  post '/posts/:id/destroy' => 'posts#destroy'
end
