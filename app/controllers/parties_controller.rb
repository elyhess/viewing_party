class PartiesController < ApplicationController
  before_action :require_user_logged_in!
  before_action :find_movie
  before_action :friends?

  def new
    @party = Current.user.parties.new
  end

  def create
    @party = Current.user.parties.new(party_params.merge(movie_id: @movie.id))
    if @party.save
      params[:party][:party_guests].each do |id|
        party.party_guests.create(user_id: id, party_id: party.id)
      end
      redirect_to dashboard_path
    else
      render :new
    end
  end

  private

  def find_movie
    @movie = Movie.find_by(api_id: session[:movie_api_id])
  end

  def party_params
    params.require(:party).permit(:name, :datetime)
  end

  def friends?
    redirect_to dashboard_path, notice: 'Add friends to create a viewing party' if Current.user.friends.empty?
  end
end
