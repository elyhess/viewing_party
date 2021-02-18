require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:movie) }
    it { should have_many(:party_guests) }
  end

  describe 'instance method' do
    it 'can determine party host' do
      @user = User.create!(email: "ely@me.com", password: "password")
      allow_any_instance_of(Current).to receive(:user).and_return(@user)
      @movie = Movie.create!(title: "Great Ape", api_id: 123, runtime: 1234)
      @party = Party.create!(movie_id: @movie.id, user_id: @user.id, datetime: DateTime.now)
      expect(@party.party_host?).to eq(true)
    end

    it 'can add party guests' do
      @movie = Movie.create!(title: "Great Ape", api_id: 123, runtime: 1234)
      @user = User.create!(email: "a@me.com", password: "password")
      @user1 = User.create!(email: "x@me.com", password: "password")
      @user2 = User.create!(email: "z@me.com", password: "password")
      @party = Party.create!(movie_id: @movie.id, user_id: @user.id, datetime: DateTime.now)

      @party.add_party_guests([@user1.id, @user2.id])

      expect(PartyGuest.count).to eq(2)
    end
  end
end
