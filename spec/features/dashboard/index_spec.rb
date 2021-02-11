require 'rails_helper'

describe "as a logged in user" do
	describe "when on the dashboard page" do
		before :each do
			@user = User.create(email: "ely@me.com", password: "password")
			allow_any_instance_of(Current).to receive(:user).and_return(@user)
		end

		it 'I can see my friends' do
			@user2 = @user.friends.create(email: "friend@me.com", password: "password")
			@user3 = @user.friends.create(email: "otherfriend@me.com", password: "password")

			visit dashboard_path

			expect(page).to have_content("Friends")
			expect(page).to have_content(@user2.email)
			expect(page).to have_content(@user3.email)
		end

		it 'I can see my inverse friends', :skip_before do
			@user2 = User.create(email: "ely@me.com", password: "password")
			@user = @user2.friends.create(email: "friend@me.com", password: "password")

			allow_any_instance_of(Current).to receive(:user).and_return(@user)

			visit dashboard_path

			expect(page).to have_content("Friends")
			expect(page).to have_content(@user2.email)
		end

		it "I cant add friends or inverse friends im already friends with", :skip_before do
			@user1 = User.create(email: "1@me.com", password: "password")
			@user2 = @user1.friends.create(email: "2@me.com", password: "password")

			allow_any_instance_of(Current).to receive(:user).and_return(@user2)

			visit dashboard_path

			expect(page).to have_content(@user1.email)

			fill_in "friendship[email]", with: @user1.email
			click_button "Add Friend"


			expect(page).to have_content("You're already friends with this person.")
		end

		it 'I can see a message if i have no friends' do
			visit dashboard_path

			expect(page).to have_content("You have no friends, add some to get started!")
		end

		it 'I can click the discover movies link' do
			visit dashboard_path

			expect(page).to have_link("Discover Movies")

			click_link "Discover Movies"
			expect(current_path).to eq(discover_path)
		end

		it 'I can see a link to create a movie party if i have no parties' do
			visit dashboard_path

			expect(page).to have_content("You have no viewing parties, search a movie to create one!")
			expect(page).to have_link("search")

			click_link "search"

			expect(current_path).to eq(discover_path)
		end

		it 'I can see the viewing parties i am hosting', :skip_before do
			@user = User.create(email: "ely@me.com", password: "password")
			@user2 = @user.friends.create!(email: "friend@me.com", password: "password")
			@user3 = @user.friends.create!(email: "otherfriend@me.com", password: "password")

			allow_any_instance_of(Current).to receive(:user).and_return(@user)

			@movie = Movie.create!(title: "Great Film", api_id: 123123, runtime: "125")

			@party = @user.parties.create!(name: "My Party", datetime: "2021-02-09 18:52:21 UTC", movie_id: @movie.id)

			@guest1 = @party.party_guests.create!(user_id: @user2.id, party_id: @party.id)
			@guest2 = @party.party_guests.create!(user_id: @user3.id, party_id: @party.id)


			visit dashboard_path

			expect(page).to have_content("Your Movie Parties")
			expect(page).to have_content(@movie.title)
			expect(page).to have_content("February 09, 2021 18:52")
			expect(page).to have_content("Status: Hosting")
		end

		it 'I can see the viewing parties i am invited to', :skip_before do
			@user = User.create(email: "ely@me.com", password: "password")
			@user2 = @user.friends.create!(email: "friend@me.com", password: "password")
			@user3 = @user.friends.create!(email: "otherfriend@me.com", password: "password")

			allow_any_instance_of(Current).to receive(:user).and_return(@user2)

			@movie = Movie.create!(title: "Great Film", api_id: 123123, runtime: "125")

			@party = @user.parties.create!(name: "My Party", datetime: "2021-02-09 18:52:21 UTC", movie_id: @movie.id)

			@guest1 = @party.party_guests.create!(user_id: @user2.id, party_id: @party.id)
			@guest2 = @party.party_guests.create!(user_id: @user3.id, party_id: @party.id)

			visit dashboard_path

			expect(page).to have_content("Your Movie Parties")
			expect(page).to have_content(@movie.title)
			expect(page).to have_content("February 09, 2021 18:52")
			expect(page).to have_content("Status: Invited")
		end

		it 'I can see both parties i am host of, and invited to', :skip_before do
			@user = User.create(email: "ely@me.com", password: "password")
			@user2 = @user.friends.create!(email: "friend@me.com", password: "password")

			allow_any_instance_of(Current).to receive(:user).and_return(@user)

			@movie = Movie.create!(title: "Great Film", api_id: 123123, runtime: "125")
			@movie2 = Movie.create!(title: "Another Film", api_id: 123123, runtime: "125")

			@party = @user.parties.create!(name: "My Party", datetime: "2021-02-09 18:52:21 UTC", movie_id: @movie.id)
			@party2 = @user2.parties.create!(name: "Cool Party", datetime: "2021-02-09 18:52:21 UTC", movie_id: @movie2.id)

			@guest1 = @party.party_guests.create!(user_id: @user2.id, party_id: @party.id)
			@guest2 = @party2.party_guests.create!(user_id: @user.id, party_id: @party2.id)

			visit dashboard_path

			expect(page).to have_content("Your Movie Parties")
			expect(page).to have_content(@movie.title)
			expect(page).to have_content("February 09, 2021 18:52")
			expect(page).to have_content("Status: Hosting")

			expect(page).to have_content("Your Movie Parties")
			expect(page).to have_content(@movie2.title)
			expect(page).to have_content("February 09, 2021 18:52")
			expect(page).to have_content("Status: Invited")
		end

		it 'I can not see parties I was not invited to', :skip_before do
			@user = User.create(email: "ely@me.com", password: "password")
			@user2 = @user.friends.create!(email: "123@me.com", password: "password")
			@user3 = @user.friends.create!(email: "x@me.com", password: "x")

			allow_any_instance_of(Current).to receive(:user).and_return(@user3)

			@movie = Movie.create!(title: "Great Film", api_id: 123123, runtime: "125")

			@party = @user.parties.create!(name: "My Party", datetime: "2021-02-09 18:52:21 UTC", movie_id: @movie.id)

			@party.party_guests.create!(user_id: @user2.id, party_id: @party.id)

			visit dashboard_path

			expect(page).to_not have_content(@movie.title)
			expect(page).to_not have_content("February 09, 2021 18:52")
			expect(page).to_not have_content("Status: Invited")
		end

	end
end


