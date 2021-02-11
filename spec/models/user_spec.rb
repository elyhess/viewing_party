require 'rails_helper'

RSpec.describe User do
  describe 'relationships', type: :model do
    it { should have_many(:friendships) }
    it { should have_many(:friends).through(:friendships) }
    it { should have_many(:inverse_friends) }
    it { should have_many(:inverse_friends).through(:inverse_friendships) }
    it { should have_many(:parties) }
    it { should have_many(:party_guests) }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  describe 'instance methods' do
    it 'saves email as lower case' do
      email1 = 'ROB@ME.COM'
      @user = User.create(email: email1, password: '123abc')

      expect(@user.email).to eq('rob@me.com')
    end

    it 'returns all friends' do
      @user = User.create(email: "ely@me.com", password: "password")
      @user2 = User.create(email: "friend@me.com", password: "password")

      Friendship.create(user_id: @user.id, friend_id: @user2.id)
      Friendship.create(user_id: @user2.id, friend_id: @user.id)

      expect(@user.all_friends).to eq([@user2])
    end

    it 'returns no friends' do
      @user = User.create(email: "ely@me.com", password: "password")
      @user2 = User.create(email: "friend@me.com", password: "password")

      expect(@user.no_friends?).to eq(true)
    end

    it 'returns party invites' do
      @user = User.create(email: "ely@me.com", password: "password")
      allow_any_instance_of(Current).to receive(:user).and_return(@user)
      @user2 = User.create(email: "friend@me.com", password: "password")

      Friendship.create(user_id: @user.id, friend_id: @user2.id)
      Friendship.create(user_id: @user2.id, friend_id: @user.id)

      @movie = Movie.create!(title: "Great Film", api_id: 123123, runtime: "125")

      @party = @user.parties.create!(name: "My Party", datetime: "2021-02-09 18:52:21 UTC", movie_id: @movie.id)

      @guest1 = @party.party_guests.create!(user_id: @user.id, party_id: @party.id)

      expect(@user2.party_invites).to eq([@party])
    end

  end
end
