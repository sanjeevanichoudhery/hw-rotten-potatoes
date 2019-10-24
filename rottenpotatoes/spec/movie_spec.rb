
require 'rails_helper'

describe Movie do
  describe '.find_similar_movies' do
    
    #creating our model using FactoryBot *** taught in class *** before each spec test
    before :each do
      #Movie.destroy_all #clear the database --just in case but not used here  ---- these examples were taken from a stack overflow 
      @movie1 = FactoryBot.create(:movie, title: 'Catch me if you can', director: 'Steven Spielberg') 
      @movie2 =  FactoryBot.create(:movie, title: 'Seven', director: 'David Fincher') 
      @movie3 =  FactoryBot.create(:movie, title: "Schindler's List", director: 'Steven Spielberg') 
      @movie4 =  FactoryBot.create(:movie, title: "Stop") 
    end
    
    #testing that the correct combination of movies is shown for looking at similarity of the director
    context 'director exists' do
      it 'finds similar movies correctly' do
        expect(Movie.similar_movies(@movie1.title).pluck(:title)).to match_array [@movie1.title,@movie3.title]
        expect(Movie.similar_movies(@movie1.title).pluck(:title)).to_not include([@movie2.title])
        expect(Movie.similar_movies(@movie2.title).pluck(:title)).to eql([@movie2.title])
      end
   end

  #making sure sad path had a nil return 
   context 'director does not exist' do
      it 'handle sad path' do
        expect(Movie.similar_movies(@movie4.title)).to eql(nil)
      end
    end
  end


  #show all the rating when all ratings is called. 
  describe '.all_ratings' do
    it 'returns all ratings' do
      expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
    end
  end
end