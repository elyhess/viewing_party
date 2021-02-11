class MoviesController < ApplicationController
  before_action :require_user_logged_in!

  def index
    if params[:movie_name].present?
      @movies = MoviesFacade.get_movies(params[:movie_name])
    elsif params[:top_movies].present?
      @movies = MoviesFacade.top_movies
    elsif params[:trending_movies].present?
      @movies = MoviesFacade.weekly_top_trends
    elsif params[:upcoming_movies].present?
      @movies = MoviesFacade.upcoming_movies
    else
      redirect_to discover_path
      flash[:alert] = 'Please enter a movie title'
    end
  end

  def show
    @movie = MoviesFacade.get_movie(params[:id])
  end

  def create
    make_movie || @movie = Movie.create(api_id: params[:api_id], runtime: params[:runtime], title: params[:title])
    session[:movie_api_id] = params[:api_id]
    redirect_to new_party_path
  end

  private

  def make_movie
    @movie = Movie.find_by(api_id: params[:api_id])
  end
end
