class Party < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  has_many :party_guests, dependent: :destroy

  validates :datetime, presence: true

  def party_host?
    Current.user.id == user_id
  end

  def add_party_guests(guest_ids)
    guest_ids.each do |id|
      party_guests.create(user_id: id, party_id: self.id)
    end
  end
end
