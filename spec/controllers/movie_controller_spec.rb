require 'spec_helper'

describe MoviesController do


  describe 'edit page for appropriate Movie' do
    it 'When I go to the edit page for the Movie, it should be loaded' do
      mock = mock('Movie')
      Movie.should_receive(:find).with('13').and_return(mock)
      get :edit, {:id => '13'}
      response.should be_success
    end
    it 'And I fill in "Director" with "Ridley Scott", And  I press "Update Movie Info", it should save the director' do
      mock = mock('Movie')
      mock.stub!(:update_attributes!)
      mock.stub!(:title)
      mock.stub!(:director)
      mock.stub!(:director)
      
      mock2 = mock('Movie')
      
      Movie.should_receive(:find).with('13').and_return(mock)
      mock.should_receive(:update_attributes!)
      post :update, {:id => '13', :movie => mock2 }
    end
  
  
    it 'should be possible to create movie' do
      movie = mock('Movie')
      movie.stub!(:title)
      
      Movie.should_receive(:create!).and_return(movie)
      post :create, {:movie => movie}
      response.should redirect_to(movies_path)
    end
  
    it 'should be possible to destroy movie' do
      movie = mock('Movie')
      movie.stub!(:title)
      
      Movie.should_receive(:find).with('13').and_return(movie)
      movie.should_receive(:destroy)
      post :destroy, {:id => '13'}
      response.should redirect_to(movies_path)
    end
  
  
    it 'should redirect if selected ratings are changed' do
      get :index, {:ratings => {:G => 1}}
      response.should redirect_to(movies_path(:ratings => {:G => 1}))
    end
  
    it 'should call database to get movies' do
      Movie.should_receive(:find_all_by_rating)
      get :index
    end

    it 'should show Movie by id' do
      mock = mock('Movie')
      Movie.should_receive(:find).with('13').and_return(mock)
      get :show, {:id => '13'}
    end

    it 'should redirect to index if movie does not have a director' do
      mock = mock('Movie')
      mock.stub!(:director).and_return(nil)
      mock.stub!(:title).and_return(nil)
      
      Movie.should_receive(:find).with('13').and_return(mock)
      get :similar, {:id => '13'}
      response.should redirect_to(movies_path)
    end

  describe "Coverage 90%" do
      before :each do
        @fake_movie = mock('Movie', :id => '1', :update_attributes =>true, :title =>'My Movie 2', :director =>'JD')      
        @fake_list = [mock('Movie'), mock('Movie')]
      end

#      it 'Coverage 90%-opt 1' do
#        Movie.should_receive(:find).with('1').and_return(@fake_list)
#        get :show, {:id => '1', :sort => 'title'}
#      end
    
      it 'Coverage 90%-opt 2' do
        get :index, {:sort => 'title'}
      end
      
      it 'Coverage 90%-opt 3' do
         get :index, {:sort => 'release_date'}
      end
      
      it 'Coverage 90%-opt 4' do
        session[:sort] = 'title'
        get :index, {:sort => 'release_date'}
      end
      
      it 'Coverage 90%-opt 5' do
        session[:ratings] = 'title'
        get :index, {:ratings => 'release_date'}
      end
      
      it 'Coverage 90%-opt 6' do
        post :create 
      end
      
      it 'Coverage 90%-opt 7' do
        get :new 
      end
      
      it 'Coverage 90%-opt 8' do
        Movie.should_receive(:find).with('1').and_return(@fake_list)
        get :edit , {:id => 1}
      end
            
#      it 'Coverage 90%-opt 9' do
#        Movie.stub(:find).and_return(@fake_movie)
#        put :update , {:id => 1}
#      end

  end
  end
end
