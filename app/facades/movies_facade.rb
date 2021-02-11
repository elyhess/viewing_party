class MoviesFacade
  class << self
    def get_movies(movie)
      create_movies(MoviesService.search_by_movie(movie))
    end

    def top_movies
      create_movies(MoviesService.top_rated_movies)
    end

    def weekly_top_trends
      create_movies(MoviesService.top_trending_movies)
    end

    def get_movie(movie)
      movie_data = MoviesService.find_movie(movie)
      movie_cast = MoviesService.retrieve_cast(movie)[:cast][0..9]
      movie_reviews = MoviesService.retrieve_reviews(movie)[:results]
      Film.new(movie_data, movie_cast, movie_reviews)
    end

    def upcoming_movies_fart
      create_movies(MoviesService.upcoming_movies[:results])
    end

    private

    def create_movies(movies_data)
      movies_data.map do |movie_data|
        Film.new(movie_data)
      end
    end
  end
end
