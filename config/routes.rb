Rottenpotatoes::Application.routes.draw do
  #resources :movies
  # map '/' to be a redirect to '/movies'
  #root :to => redirect('/movies')
  root 'movies#index'
  resources :movies
end
