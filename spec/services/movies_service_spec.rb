require 'rails_helper'

describe MoviesService do
  it 'exists' do
    @service = MoviesService.new
    expect(@service).to be_an_instance_of(MoviesService)
  end

  it 'retrieves reviews', :vcr do
    respsonse = MoviesService.retrieve_reviews(8587)

    expect(respsonse).to be_a(Hash)
    expect(respsonse).to have_key(:results)
  end
  
  it 'retrieves cast', :vcr do
    response = MoviesService.retrieve_cast(8587)

    expect(response).to be_a(Hash)
    expect(response).to have_key(:cast)
  end
  
  it 'finds movie', :vcr do
    response = MoviesService.find_movie(8587)

    expect(response).to be_a(Hash)

    expect(response).to have_key(:id)
    expect(response[:id]).to be_a(Integer)

    expect(response).to have_key(:title)
    expect(response[:id]).to be_a(Integer)

    expect(response).to have_key(:vote_average)
    expect(response[:vote_average]).to be_a(Float)
    
    expect(response).to have_key(:runtime)
    expect(response[:runtime]).to be_a(Integer)
    
    expect(response).to have_key(:popularity)
    expect(response[:popularity]).to be_a(Float)
    
    expect(response).to have_key(:genres)
    expect(response[:genres]).to be_an(Array)
    expect(response[:genres][0]).to be_a(Hash)
    expect(response[:genres][0][:name]).to be_a(String)

    expect(response).to have_key(:overview)
    expect(response[:overview]).to be_a(String)
    
    expect(response).to have_key(:poster_path)
    expect(response[:poster_path]).to be_a(String)
  end

  it 'trending movies', :vcr do
    response = MoviesService.top_trending_movies

    expect(response).to be_a(Hash)
    expect(response).to have_key(:results)

    expect(response[:results]).to be_an(Array)
    expect(response[:results][0]).to be_a(Hash)

    expect(response[:results][0]).to have_key(:poster_path)
    expect(response[:results][0][:poster_path]).to be_a(String)

    expect(response[:results][0]).to have_key(:title)
    expect(response[:results][0][:title]).to be_a(String)

    expect(response[:results][0]).to have_key(:vote_average)
    expect(response[:results][0][:vote_average]).to be_a(Float)

    expect(response[:results][0]).to have_key(:overview)
    expect(response[:results][0][:overview]).to be_a(String)

  end
end
