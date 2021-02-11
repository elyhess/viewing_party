require 'rails_helper'

describe MoviesFacade do
  it 'exists' do
    movies_facade = MoviesFacade.new

    expect(movies_facade).to be_an_instance_of(MoviesFacade)
  end

  it "can return top rated movie objects", :vcr do
    movies_facade = MoviesFacade.top_movies

    expect(movies_facade.count).to eq(40)
    expect(movies_facade.first).to be_an_instance_of(Film)
  end

  it 'can return one specifed movie object', :vcr do
    lion_king = MoviesFacade.get_movie(8587)

    expect(lion_king).to be_an_instance_of(Film)
  end

  it 'can return multiple results from one movie query search', :vcr do
    movies_facade = MoviesFacade.get_movies("Pulp Fiction")

    expect(movies_facade.count).to eq(6)
    expect(movies_facade.first).to be_an_instance_of(Film)
  end

  it 'can return top trending movies', :vcr do
    movies_facade = MoviesFacade.weekly_top_trends

    expect(movies_facade.count).to eq(40)
    expect(movies_facade.first).to be_an_instance_of(Film)
  end

  it 'can return upcoming', :vcr do
    movies_facade = MoviesFacade.upcoming_movies

    expect(movies_facade.count).to eq(20)
    expect(movies_facade.first).to be_an_instance_of(Film)
  end

end
