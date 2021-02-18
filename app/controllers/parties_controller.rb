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
      if params[:party][:party_guests].present?
        @party.add_party_guests(params[:party][:party_guests])
        redirect_to dashboard_path
      else
        redirect_to new_party_path, notice: "Add friends to create a party."
      end
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
