class MoviesController < ApplicationController
  before_action :require_user_logged_in!

  def index
    if params[:movie_name].present?
      @movies = MoviesFacade.get_movies(params[:movie_name])
    elsif params[:top_movies]
      @movies = MoviesFacade.get_top_movies
    else
      redirect_to discover_path
      flash[:alert] = "Please enter a movie title"
    end
  end

  def show
    @movie = MoviesFacade.get_movie(params[:id])
  end

  def create
    if (@movie = Movie.find_by(api_id: params[:api_id]))
      session[:movie_api_id] = params[:api_id]
      redirect_to new_party_path
    else
      @movie = Movie.create(api_id: params[:api_id], runtime: params[:runtime], title: params[:title])
      session[:movie_api_id] = params[:api_id]
      redirect_to new_party_path
    end
  end

end
