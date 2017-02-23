Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/sessions/new' => 'users#sessions'
  post '/sessions/new' => 'users#login'
  delete '/sessions' => 'users#logout'
  get '/users/new' => 'users#new_user'
  post '/users/new' => 'users#register'
  get '/users/:id' => 'users#show'
  get '/users/:id/edit' => 'users#edit_user'
  patch '/users/:id/edit' => 'users#update'
  delete '/users/:id/delete' => 'users#delete'
  get '/secrets' => 'secrets#index'
  delete '/secrets' => 'secrets#delete_from_index'
  post '/secrets' => 'secrets#new_secret'
  post '/secrets/:id/delete' => 'secrets#delete'
  post '/like' => 'likes#like'
  post '/unlike' => 'likes#unlike'
end
