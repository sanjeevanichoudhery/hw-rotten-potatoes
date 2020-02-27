Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
  get '/movies/director/:id' , to: 'movies#director', as: 'movies_director'
  get 'similar_movies/:title' => 'movies#director', as: :search_similar_movies
end