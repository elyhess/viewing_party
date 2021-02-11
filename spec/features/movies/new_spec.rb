require 'rails_helper'

describe 'movies', :vcr do
  describe 'User can create a movie' do
    before :each do
     @user = User.create(email: "ely@me.com", password: "password")
		 @user2 = User.create(email: "friend@me.com", password: "password") 
		 Friendship.create(user_id: @user.id, friend_id: @user2.id)
     Movie.create(title: "Frozen ii", api_id: 330457, runtime: 104)
     allow_any_instance_of(Current).to receive(:user).and_return(@user)
    end
    
    it 'when creating a new party' do
      visit movie_path(330457)

      expect(Movie.all.count).to eq(1)
      
      click_button('Create Movie Party')
      expect(current_path).to eq(new_party_path)
      expect(Movie.all.count).to eq(1)
    end
  end
end