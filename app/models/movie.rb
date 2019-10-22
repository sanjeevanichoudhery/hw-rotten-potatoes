class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  # Input: title of the movie
  # Output: table where the director matches or nil if non-existent
  # Fulfills the purpose of fulfilling the task of querying the Movie database for movies with same director
  def self.similar_movies movie_title
    curr_director = Movie.find_by(title: movie_title).director
    puts "---------------------------"
    puts curr_director
    if curr_director.blank? or curr_director.nil?
      return nil
    else
      Movie.where(director: curr_director)
    end
  end
end
