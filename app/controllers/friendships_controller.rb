class FriendshipsController < ApplicationController
  before_action :require_user_logged_in!
  before_action :find_friend, only: [:create]
  before_action :find_user, only: [:create]

  def create
    @friendship = Friendship.new(user_id: Current.user.id, friend_id: @friend.id)
    if @friendship.save
      redirect_to dashboard_path, notice: 'Friend added successfully.'
    else
      render template: 'dashboard/index'
    end
  end

  private

  def find_friend
    @friend = User.find_by(email: params[:friendship][:email])
    redirect_to dashboard_path, alert: 'Invalid email.' if @friend.blank?
  end

  def find_user
    @user = Current.user
  end
end
