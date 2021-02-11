require 'rails_helper'

describe "as a logged in user" do
	describe "when on the dashboard page" do
		it 'I can add friends' do
			@user = User.create(email: "ely@me.com", password: "password")
			@user2 = User.create(email: "friend@me.com", password: "password")

			allow_any_instance_of(Current).to receive(:user).and_return(@user)

			visit dashboard_path

			fill_in "friendship[email]", with: "friend@me.com"
			click_button "Add Friend"

			expect(page).to have_content("Friend added successfully.")
		end

		it "I can't add friends that do not have accounts" do
			@user = User.create(email: "ely@me.com", password: "password")

			allow_any_instance_of(Current).to receive(:user).and_return(@user)

			visit dashboard_path

			fill_in "friendship[email]", with: "friend@me.com"

			click_button "Add Friend"

			expect(page).to have_content("Invalid email.")
		end

		it "I can't add friends that i'm already friends with" do
			@user = User.create(email: "ely@me.com", password: "password")
			@user2 = User.create(email: "friend@me.com", password: "password")

			Friendship.create(user_id: @user.id, friend_id: @user2.id)

			allow_any_instance_of(Current).to receive(:user).and_return(@user)

			visit dashboard_path

			fill_in "friendship[email]", with: "friend@me.com"

			click_button "Add Friend"

			expect(page).to have_content("You're already friends with this person.")
		end

		it "I can't add myself" do
			@user = User.create(email: "ely@me.com", password: "password")

			allow_any_instance_of(Current).to receive(:user).and_return(@user)

			visit dashboard_path

			fill_in "friendship[email]", with: "ely@me.com"

			click_button "Add Friend"

			expect(page).to have_content("You Cannot Add Yourself")
		end
	end
end