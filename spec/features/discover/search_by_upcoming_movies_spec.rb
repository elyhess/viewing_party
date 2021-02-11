require 'rails_helper'

describe "as a logged in user" do
  describe "when I visit the discover page" do
    before :each do
			@user = User.create(email: "ely@me.com", password: "password")
			allow_any_instance_of(Current).to receive(:user).and_return(@user)
		end

    it 'I can see the upcoming movie', :vcr do
			visit discover_path
      
      click_button "Upcoming Movies"

      expect(current_path).to eq(movies_path)

      expect(page).to have_content("Total Results: 20")
		end
  end
end