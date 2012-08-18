require 'spec_helper'

describe Movie do
  before(:each) do
    @valid_attributes = {
      :title => "My MOVIE",
      :description => "A movie about the new world.",
      :rating => "G",
      :director => "JD",
      :release_date => Time.parse("1/1/2012")
    }
  end

  it "should create a new instance given valid attributes" do
    Movie.create(@valid_attributes).should be_true
  end
 
  it 'should valid when created with attributes' do
    @movie = Movie.create(:title => "test", :rating => "P")
    @movie.should be_valid
  end

  it 'should not be valid when created with attributes' do
    @movie = Movie.create(:title=> 'test', :rating => 'P',
                             :director => 'martin')
    @movie.should be_valid
    @movie.director.should eq 'martin'
    Movie.find_by_title('test').director.should eq 'martin'
  end
 
  describe 'When I call all_ratings' do
     it 'should return G PG PG-13 NC-17 R ' do
      char = Movie.all_ratings
 
      char.should be_an(Array)
      char.should include("G")
      char.should include("PG")
      char.should include("PG-13")
      char.should include("NC-17")
      char.should include("R")
    end
  end  
end
