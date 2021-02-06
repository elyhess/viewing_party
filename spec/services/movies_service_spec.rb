require 'rails_helper'

describe MoviesService do
  it "exists" do
    movies_services = MoviesService.new

    expect(movies_services).to be_an_instance_of(MoviesService)
  end
end