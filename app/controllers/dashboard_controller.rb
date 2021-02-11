class DashboardController < ApplicationController
  before_action :require_user_logged_in!

  def index
    @friendship = Friendship.new
    @user = Current.user
    @viewing_parties = Current.user.parties
  end
end
