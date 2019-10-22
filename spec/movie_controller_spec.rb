require 'rails_helper'

describe MoviesController, :type => :controller do
  
  describe 'Search movies by the same director' do
    it 'should call Movie.similar_movies' do
      expect(Movie).to receive(:similar_movies).with('Catch me if you can')
      get :director, { title: 'Catch me if you can' }
       
    end

    it 'similar movies exists correctly if director exists' do
      movies = ['Catch me if you can', "Schindler's List"]
      Movie.stub(:similar_movies).with('Catch me if you can').and_return(movies)
      get :director, { title: 'Catch me if you can' }
      expect(assigns(:similar_movies)).to eql(movies)
    end

    it "should redirect to home page if no director" do
      Movie.stub(:similar_movies).with('Stop').and_return(nil)
      get :director, { title: 'Stop' }
      expect(response).to redirect_to(root_url)
    end
  end
  
  
  describe 'GET index' do

    it 'should show index page' do
      get :index
      expect(response).to render_template('index')
    end

    it 'should assign sort variable to title ' do
      get :index, { sort: 'title'}
      expect(assigns(:title_header)).to eql('hilite')
    end

    it 'should assign sort variable to realease date' do
      get :index, { sort: 'release_date'}
      expect(assigns(:date_header)).to eql('hilite')
   end
  end

  describe 'GET new' do

    it 'should show new page' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'GET #show' do
    let!(:movie) { FactoryBot.create(:movie, title: 'Pirates of the Caribbean', director: 'Steven Spielberg')  }

    it 'should find the movie' do                   #test spec created from examples at --------- http://pololu.github.io/rpicsim/file.IntroductionToRSpec.html
      get :show, {id: movie.id}                            
      expect(assigns(:movie)).to match(movie)
      
    end

    it 'should render the show template' do
      get :show, id: movie.id
      expect(response).to render_template('show')
    end
  end

  describe 'GET #edit' do
    let!(:movie) { FactoryBot.create(:movie, title: 'Harry Potter')  }

    it 'should find the movie' do
      get :edit, id: movie.id
      expect(assigns(:movie)).to eql(movie)
    end

    it 'should render the edit template' do
      get :edit, id: movie.id
      expect(response).to render_template('edit')
    end
  end
  

end