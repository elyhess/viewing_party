require 'rails_helper'

describe MoviesService do
  it "exists" do
    movies_services = MoviesService.new

    expect(movies_services).to be_an_instance_of(MoviesService)
  end

  it 'can search by movie', :disable_vcr do
    pulp_fiction_response = File.read("spec/fixtures/movies_services/pulp_fiction_movie_search_query.json")
    
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?query='pulp%20fiction'").
    to_return(status: 200, body: pulp_fiction_response)
    
    pulp_fiction = MoviesService.search_by_movie("Pulp Fiction")
    require 'pry'; binding.pry
    # expect(pulp_fiction[:]).to eq() 
  end
end