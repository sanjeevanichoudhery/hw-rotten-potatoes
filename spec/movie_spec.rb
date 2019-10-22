
require 'rails_helper'

describe Movie do
  describe '.find_similar_movies' do
    before :each do
      Movie.destroy_all
      @movie1 = FactoryBot.create(:movie, title: 'Catch me if you can', director: 'Steven Spielberg') 
      @movie2 =  FactoryBot.create(:movie, title: 'Seven', director: 'David Fincher') 
      @movie3 =  FactoryBot.create(:movie, title: "Schindler's List", director: 'Steven Spielberg') 
      @movie4 =  FactoryBot.create(:movie, title: "Stop") 
    end
    
    context 'director exists' do
      it 'finds similar movies correctly' do
        expect(Movie.similar_movies(@movie1.title).pluck(:title)).to match_array [@movie1.title,@movie3.title]
        expect(Movie.similar_movies(@movie1.title).pluck(:title)).to_not include([@movie2.title])
        expect(Movie.similar_movies(@movie2.title).pluck(:title)).to eql([@movie2.title])
      end
   end

   context 'director does not exist' do
      it 'handles sad path' do
        expect(Movie.similar_movies(@movie4.title)).to eql(nil)
      end
    end
  end

  describe '.all_ratings' do
    it 'returns all ratings' do
      expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
    end
  end
end